import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:products/core/constants/app_constants.dart';
import 'package:products/core/exception/app_exceptions.dart';
import 'package:products/core/exception/exceptions.dart';
import 'package:products/features/home/data/models/product_model.dart';
import 'package:products/features/home/domain/repositories/product_repository.dart';
import 'package:products/features/home/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImpl implements ProductRepository {

  @override
  Future<Either<Failure, List<Product>>> getProducts(int page) async {
    if (await InternetConnectionChecker.instance.hasConnection) {
      try {
        final startIndex = (page - 1) * AppConstants.pageSize;
        final endIndex = startIndex + AppConstants.pageSize;

        final response = await http.get(
          Uri.parse('${AppConstants.baseUrl}${AppConstants.productsEndpoint}'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final jsonList = json.decode(response.body) as List;
          final paginatedList = jsonList.sublist(
            startIndex,
            endIndex > jsonList.length ? jsonList.length : endIndex,
          );

          return Right(paginatedList
              .map((json) => ProductModel.fromJson(json))
              .toList());
        } else {
          throw Left(ServerException('Failed to load products'));
        }
      } catch (e) {
        throw Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final jsonString = prefs.getString(AppConstants.cachedProductKey);
        if (jsonString != null) {
          final List<dynamic> jsonList = json.decode(jsonString);
          return Right(jsonList.map((json) => ProductModel.fromJson(json)).toList());
        } else {
          throw Left(CacheException('No cached products found'));
        }
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<void> storeProductsLocal(List<Product> products) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
    products.map((product) => product.toJson()).toList();
    await prefs.setString(
      AppConstants.cachedProductKey,
      json.encode(jsonList),
    );
  }
}