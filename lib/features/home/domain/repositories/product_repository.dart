
import 'package:dartz/dartz.dart';
import 'package:products/core/exception/app_exceptions.dart';
import 'package:products/features/home/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(int page);
  Future<void> storeProductsLocal(List<Product> products);
}