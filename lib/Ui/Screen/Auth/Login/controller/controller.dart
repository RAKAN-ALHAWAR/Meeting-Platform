import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class LoginController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  RxBool isEmail = true.obs;
  final loginVia = ValueNotifier(1);
  Rx<ErrorX?> error = Rx<ErrorX?>(null);

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController idNumber = TextEditingController();

  //============================================================================
  // Functions

  onTapError() {
  }

  Future<void> onLogin() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        error.value = null;
        try {
          if (isEmail.value) {
            await loginByEmail();
          } else {
            await loginByIdNumber();
          }
          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          Get.offAndToNamed(RouteNameX.root);

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

  Future<void> loginByEmail() async {
    app.user = (await DatabaseX.login(
      email: email.text.trim(),
      password: password.text.trim(),
    )).obs;

    /// save data on local
    LocalDataX.put(LocalKeyX.token, app.user.value.token);
    LocalDataX.put(LocalKeyX.route, RouteNameX.root);
    app.isLogin.value = true;
  }

  Future<void> loginByIdNumber() async {
    app.user =(await DatabaseX.login(
      email: idNumber.text.trim(),
      password: password.text.trim(),
    )).obs;

    /// save data on local
    LocalDataX.put(LocalKeyX.token, app.user.value.token);
    LocalDataX.put(LocalKeyX.route, RouteNameX.root);
    app.isLogin.value = true;

  }

  onForgotPassword() {
    Get.toNamed(RouteNameX.forgotPassword);
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();

    /// listener if change tap for login by phone or email
    loginVia.addListener(() {
      isEmail.value = loginVia.value == 1;
    });
  }
}
