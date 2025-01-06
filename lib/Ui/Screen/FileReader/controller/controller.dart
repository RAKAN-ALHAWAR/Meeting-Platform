import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Data/Model/attachment/attachment.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../Core/Service/firebaseRemoteConfigService.dart';

class FileReaderController extends GetxController {
  //============================================================================
  // Variables

  AttachmentX attachment = Get.arguments;
  late String fileType = attachment.type.toLowerCase();
  late WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progressValue) {
          progress.value = progressValue;
        },
      ),
    )
    ..loadRequest(Uri.parse(getUrl));

  final RxInt progress = 0.obs;
  final transformationController = TransformationController();
  TapDownDetails doubleTapDetails = TapDownDetails();

  //============================================================================
  // Functions

  String get getUrl {
    if (attachment.path.isURL) {
      return attachment.path;
    } else {
      var url = FirebaseRemoteConfigServiceX.getString('base_url');
      int endIndex = url.indexOf('.com');
      if (endIndex != -1) {
        return '${url.substring(0, endIndex + 4)}/${attachment.path}';
      } else {
        return '$url/${attachment.path}'.trim();
      }
    }
  }
  void handleDoubleTap() {
    if (transformationController.value != Matrix4.identity()) {
      transformationController.value = Matrix4.identity();
    } else {
      final position = doubleTapDetails.localPosition;
      transformationController.value = Matrix4.identity()
      // For a 3x zoom
        // ..translate(-position.dx * 2, -position.dy * 2)
        // ..scale(3.0);
      // Fox a 2x zoom
      ..translate(-position.dx, -position.dy)
      ..scale(2.0);
    }
  }

}
