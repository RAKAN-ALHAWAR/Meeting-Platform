import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../Config/config.dart';
import '../../../../../Data/Form/auth/update_password.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class ChangePasswordController extends GetxController {

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  /// Input Filed
  late GlobalKey<FormState> formKey;
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reNewPassword = TextEditingController();

  //============================================================================
  // Functions
  onEdit() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        try {
          String? message = await DatabaseX.updatePassword(
            form: UpdatePasswordFormX(
              oldPassword: oldPassword.text,
              newPassword: newPassword.text,
            ),
          );

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// Close the change password screen
          Get.back();
          if (message != null && message.isNotEmpty) {
            ToastX.success(message: message);
          }
        } catch (error) {
          ToastX.error(message: error.toString());
          buttonState.value = ButtonStateEX.failed;
        }
        isLoading.value = false;

        /// Reset the button state
        Timer(
          const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
              () {
            buttonState.value = ButtonStateEX.normal;
          },
        );
      } else {
        autoValidate = AutovalidateMode.always;
      }
    }
  }
}
