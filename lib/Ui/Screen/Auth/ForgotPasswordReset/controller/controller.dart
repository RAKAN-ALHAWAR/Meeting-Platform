import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Data/Form/auth/forget_password_reset.dart';
import 'package:meeting/Data/Model/User/user.dart';

import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class ForgotPasswordResetController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  UserX user = Get.arguments;

  Rx<ErrorX?> error = Rx<ErrorX?>(null);

  late GlobalKey<FormState> formKey;
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  //============================================================================
  // Functions

  onTapError() {}
  onChangePassword() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        error.value = null;
        try {
          await DatabaseX.forgetPasswordReset(
            form: ForgetPasswordResetFormX(
              token:user.token,
              newPassword: password.text,
            ),
          );

          app.user = user.obs;

          /// save data on local
          LocalDataX.put(LocalKeyX.token, app.user.value.token);
          LocalDataX.put(LocalKeyX.route, RouteNameX.root);
          app.isLogin.value = true;

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// go to home
          Get.offAllNamed(RouteNameX.root);
        } catch (e) {
          error.value = e.toErrorX;
          error.value?.log();
          buttonState.value = ButtonStateEX.failed;
          ToastX.error(message: error);
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
