import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:products/features/home/domain/entities/product_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';


@RoutePage()
class DetailPage extends StatefulWidget {
  final Articles product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    _controller.loadHtmlString(widget.product.bodyHtml ?? "");
    _controller.enableZoom(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? ""),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
