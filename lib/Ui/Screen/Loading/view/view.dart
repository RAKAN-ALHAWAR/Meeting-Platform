import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../Widget/Basic/Utils/future_builder.dart';
import '../controller/controller.dart';

class LoadingView extends GetView<LoadingController> {
  const LoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilderX(
        future: controller.init,
        onSuccess: controller.finish,
        loading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    ImageX.sponsorLogo,
                    height: 80,
                  ),
                  const SizedBox(height: 25),
                  Image.asset(
                    ImageX.logo,
                    height: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70, width: double.maxFinite),
            const CircularProgressIndicator(),
          ],
        ),
        child: (_)=> const SizedBox(),
      ),
    );
  }
}