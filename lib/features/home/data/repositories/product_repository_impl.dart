import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:products/core/api/api_service.dart';
import 'package:products/core/constants/app_constants.dart';
import 'package:products/core/exception/app_exceptions.dart';
import 'package:products/core/exception/exceptions.dart';
import 'package:products/features/home/domain/repositories/product_repository.dart';
import 'package:products/features/home/domain/entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImpl implements ProductRepository {

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProducts(int page) async {
    if (await InternetConnectionChecker.instance.hasConnection) {
      try {
        final startIndex = (page - 1) * AppConstants.pageSize;
        final endIndex = startIndex + AppConstants.pageSize;
        final response = await ApiService().get(endpoint: AppConstants.productsEndpoint);
        Product product = Product.fromJson(response);
        final jsonList = product.articles;
        List<Articles>? paginatedList = jsonList?.sublist(
          0,
          endIndex > jsonList.length ? jsonList.length : endIndex,
        );
        return Right({
          "data" : paginatedList ?? [],
          "totalLength" : jsonList?.length ?? 0,
        });
      } catch (e) {
        throw Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final jsonString = prefs.getString(AppConstants.cachedProductKey);
        final startIndex = (page - 1) * AppConstants.pageSize;
        final endIndex = startIndex + AppConstants.pageSize;
        if (jsonString != null) {
          Product product = Product.fromJson(json.decode(jsonString));
          final jsonList = product.articles;
          List<Articles>? paginatedList = jsonList?.sublist(
            0,
            endIndex > jsonList.length ? jsonList.length : endIndex,
          );
          return Right({
            "data" : paginatedList ?? [],
            "totalLength" : jsonList?.length ?? 0,
          });
        } else {
          throw Left(CacheException('No cached products found'));
        }
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<void> storeProductsLocal(Product products) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = products.toJson();
    await prefs.setString(
      AppConstants.cachedProductKey,
      json.encode(response),
    );
  }
}