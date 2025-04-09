import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/UI/Widget/widget.dart';

import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Data/Model/auth/otp.dart';
import '../../../../../Data/data.dart';

class ForgotPasswordController extends GetxController {
  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  RxBool isEmail = true.obs;
  Rx<ErrorX?> error = Rx<ErrorX?>(null);

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController email = TextEditingController();

  //============================================================================
  // Functions

  onSend() async{
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        error.value = null;
        try {
          var message = await DatabaseX.forgetPassword(email: email.text.trim());

          if(message!=null){
            ToastX.success(message: message);
          }

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// create otp object
          OtpX otp = OtpX(
            email: email.text.trim(),
            isLogin: true,
            isPhone: false,
          );
          Get.toNamed(RouteNameX.otp, arguments: otp);
        } catch (e) {
          error.value = e.toErrorX;
          error.value!.log();
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