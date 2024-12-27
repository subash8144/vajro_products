import 'package:products/features/home/domain/entities/product_entity.dart';

class ProductModel extends Product {
  ProductModel({
    required super.articles,
    required super.status
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      articles: json['articles'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articles': articles,
      'status': status,
    };
  }
}