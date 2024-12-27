import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:products/core/routes/app_router.dart';
import 'package:products/features/home/domain/entities/product_entity.dart';
import 'package:products/features/home/presentation/pages/detail_page.dart';

class ProductItemWidget extends StatelessWidget {
  final Articles product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageAspectRatio = product.image!.width! / product.image!.height!;
    final imageHeight = screenWidth / imageAspectRatio;
    return InkWell(
      onTap: ()=> context.router.push(DetailRoute(product: product)),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*AspectRatio(
              aspectRatio: imageAspectRatio,
              child: Image.network(
                product.image?.src ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),*/
            Image.network(
              product.image?.src ?? "",
              width: screenWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported, size: 100),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                      color: Colors.black26
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.title ?? "",
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Html(
                data: product.summaryHtml ?? "",
                style: {
                  "p": Style(
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: FontSize.medium,
                  ),
                },
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}