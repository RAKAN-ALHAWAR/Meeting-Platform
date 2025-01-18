import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../Config/config.dart';
import '../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';

class MyWebViewView extends GetView<MyWebViewController> {
  const MyWebViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWebViewController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarX(
            title: controller.appBarTitle,
          ),
          body: SafeArea(child: Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.isUrlValid.value) {
                return Center(
                  child: Stack(
                    children: [
                      // WebView الرئيسي
                      WebViewWidget(
                        controller: controller.webViewController,
                      ),
                      if (controller.isLoadingWeb.value || controller.errorMessage.value != null)
                        Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          color: Colors.white,
                        ),

                      // عرض حالة التحميل
                      if (controller.isLoadingWeb.value && controller.errorMessage.value == null)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text("${controller.progress.toStringAsFixed(0)}% تحميل...",textDirection: TextDirection.rtl,),
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
                                    controller.errorMessage.value??'',
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
                        controller.url,
                        style: TextStyleX.supTitleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
            },
          )),
        );
      },
    );
  }
}
