import 'dart:async';

import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class DeleteSignatureSheetController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  //============================================================================
  // Functions

  onDeleteSignature() async {
    try {
      if (isLoading.isFalse) {
        buttonState.value = ButtonStateEX.loading;
        isLoading.value = true;
        var message = await DatabaseX.deleteAllSignature();
        app.user.value.signatureImageUrl = null;

        /// The time delay here is aesthetically beneficial
        buttonState.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(
            seconds: StyleX.successButtonSecond,
          ),
        );
        Get.back(result: true);
        if (message != null) {
          ToastX.success(message: message);
        }
      }
    } catch (e) {
      ToastX.error(message: e.toString());
    }
    isLoading.value = false;

    /// Reset the button state
    Timer(
      const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
      () {
        buttonState.value = ButtonStateEX.normal;
      },
    );
  }
}
