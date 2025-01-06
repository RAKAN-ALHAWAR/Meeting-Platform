import 'dart:async';

import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class AcceptDelegateSheetController extends GetxController {
  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;
  late String id;

  //============================================================================
  // Functions

  onAcceptDelegate() async {
    try {
      if (isLoading.isFalse) {
        buttonState.value = ButtonStateEX.loading;
        isLoading.value = true;
        var message = await DatabaseX.confirmDelegate(
          id: id,
          isConfirm: true,
        );

        /// The time delay here is aesthetically beneficial
        buttonState.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
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
