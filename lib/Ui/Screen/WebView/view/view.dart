import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../Config/config.dart';
import '../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';

class MyWebViewView extends GetView<MyWebViewController> {
  const MyWebViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(title: controller.getMeetingPlatformName()),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.handleExternalNavigation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(controller.isUrlValid.value){
              if (controller.isGoogleMeet.value) {
                return Center(
                  child: TextX(
                    'You will be redirected to an external application.',
                    color: ColorX.primary,
                    textAlign: TextAlign.center,
                  ).marginSymmetric(horizontal: 20),
                );
              } else {
                return Obx(
                      () => Stack(
                    children: [
                      SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: InAppWebView(
                          initialUrlRequest:
                          URLRequest(url: WebUri(controller.webUrl)),
                          onWebViewCreated: (cont) {
                            controller.webViewController = cont;
                          },
                          shouldOverrideUrlLoading:
                          controller.shouldOverrideUrlLoading,
                          onProgressChanged: (cont, progress) {
                            controller.updateLoadingProgress(progress);
                          },
                          onLoadStop: (controller, url) {
                            controller.evaluateJavascript(source: '''
    navigator.mediaDevices.getUserMedia({ audio: true })
    .then((stream) => console.log("Microphone access granted"))
    .catch((error) => console.log("Microphone access denied: ", error));
  ''');

                            controller.evaluateJavascript(
                                source:
                                'javascript:navigator.clipboard.writeText = (msg) => { return window.flutter_inappwebview?.callHandler("axs-wallet-copy-clipboard", msg); }');

                            controller.addJavaScriptHandler(
                              handlerName: 'axs-wallet-copy-clipboard',
                              callback: (args) {
                                print(args);
                              },
                            );
                          },

                          onReceivedError: (cont, request, error) {
                            // controller.errorMessage.value =
                            // "⚠️ ${'Error loading page'.tr}: ${error.description}";
                          },
                          onPermissionRequest: (controller, request) async {
                            return PermissionResponse(
                              resources: request.resources,
                              action: PermissionResponseAction.GRANT,
                            );
                          },
                          initialSettings: InAppWebViewSettings(
                            mediaPlaybackRequiresUserGesture: false,
                            allowsInlineMediaPlayback: true,
                            useHybridComposition: true,
                            javaScriptEnabled: true,
                            javaScriptCanOpenWindowsAutomatically: true,
                            supportMultipleWindows: true,
                            iframeAllow: "microphone; camera;",
                            iframeAllowFullscreen: true,
                            allowsAirPlayForMediaPlayback: true,
                            allowBackgroundAudioPlaying: true,
                          ),
                          onConsoleMessage: (controller, consoleMessage) {
                          print("JS Console: ${consoleMessage.message}");
                        },
                        ),
                      ),
                      if (controller.isLoading.value ||
                          controller.errorMessage.value != null)
                        Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                      if (controller.isLoading.value &&
                          controller.errorMessage.value == null)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text(
                                "${controller.progress.value}% ${'loading'.tr}...",
                              ),
                            ],
                          ),
                        ),
                      if (controller.errorMessage.value != null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: TextX(
                                    controller.errorMessage.value ?? '',
                                    color: ColorX.danger,
                                    style: TextStyleX.titleLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextX(
                      "The provided URL is invalid".tr,
                      color: ColorX.danger,
                      style: TextStyleX.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    TextX(
                      controller.webUrl,
                      style: TextStyleX.supTitleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
