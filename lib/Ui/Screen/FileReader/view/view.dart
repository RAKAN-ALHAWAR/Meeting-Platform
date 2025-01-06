import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Section/GeneralState/error.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';

class FileReaderView extends GetView<FileReaderController> {
  const FileReaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.attachment.name}.${controller.attachment.type}',
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (FunctionX.isImage(controller.fileType))
              Expanded(
                child: GestureDetector(
                  onDoubleTapDown: (d) => controller.doubleTapDetails = d,
                  onDoubleTap: controller.handleDoubleTap,
                  child: Center(
                    child: InteractiveViewer(
                      transformationController:
                          controller.transformationController,
                      panEnabled: true,
                      minScale: 1.0,
                      maxScale: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.network(
                          controller.getUrl,
                          fit: BoxFit.contain,
                          height: double.maxFinite,
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (controller.fileType == 'pdf')
              Expanded(
                child: Padding(
                  padding: StyleX.paddingApp,
                  child: PDF(
                    backgroundColor: Get.theme.scaffoldBackgroundColor,
                    fitPolicy: FitPolicy.BOTH,
                    pageSnap: false,
                    pageFling: false,
                  ).fromUrl(
                    controller.getUrl,
                    placeholder: (progress) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 10),
                            TextX('$progress %'),
                          ],
                        ),
                      );
                    },
                    errorWidget: (error) => ErrorView(error: error),
                  ),
                ),
              ),
            if (!FunctionX.isImage(controller.fileType) &&
                controller.fileType != 'pdf')
              Expanded(child: Obx(
                () {
                  return Stack(
                    children: [
                      GestureDetector(
                        onDoubleTapDown: (d) => controller.doubleTapDetails = d,
                        onDoubleTap: controller.handleDoubleTap,
                        child: Center(
                          child: InteractiveViewer(
                            transformationController:
                                controller.transformationController,
                            panEnabled: true,
                            minScale: 1.0,
                            maxScale: 4.0,
                            child: WebViewWidget(
                              controller: controller.webViewController,
                            ),
                          ),
                        ),
                      ),
                      if (controller.progress.value != 100)
                        Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          color: Get.theme.scaffoldBackgroundColor,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 10),
                                TextX('${controller.progress.value} %'),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              )),
          ],
        ).fadeAnimation200,
      ),
    );
  }
}
