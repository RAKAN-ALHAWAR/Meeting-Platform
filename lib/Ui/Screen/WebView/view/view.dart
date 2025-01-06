import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/controller.dart';

class MyWebViewView extends GetView<MyWebViewController> {
  const MyWebViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWebViewController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.appBarTitle),
          ),
          body: SafeArea(
            child: WebViewWidget(
              controller: controller.webViewController,
            ),
          ),
        );
      },
    );
  }
}