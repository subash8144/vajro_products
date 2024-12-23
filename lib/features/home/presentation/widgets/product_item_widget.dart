import 'package:flutter/material.dart';
import 'package:products/features/home/domain/entities/product_entity.dart';
import '../../data/models/product_model.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image,
        width: 100,
        fit: BoxFit.cover,
      ),
      title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        product.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        // Handle detailed view
      },
    );
  }
}