import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meeting/Data/Form/Auth/forget_password_otp_check_code.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Model/User/user.dart';
import '../../../../../Data/data.dart';
import '../../../../Widget/Package/otp_pin_field_widget/src/otp_pin_field_state.dart';
import '../../../../Widget/widget.dart';

class OTPController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxBool isResendAgain = false.obs;
  RxBool isLoadingResendAgain = false.obs;
  RxBool isDoneInput = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  late String email = Get.arguments;

  TextEditingController otpCode = TextEditingController();
  final GlobalKey<OtpPinFieldState> otpKey = GlobalKey<OtpPinFieldState>();

  late Timer timer;
  RxInt start = 60.obs;

  Rx<ErrorX?> error = Rx<ErrorX?>(null);

  //============================================================================
  // Functions

  onTapError() {
    /// Add a link to go to pages through the error message
  }

  onVerify() async {
    if (isLoading.isFalse) {
      isLoading.value = true;
      buttonState.value = ButtonStateEX.loading;
      error.value = null;
      try {
        UserX user = await DatabaseX.forgetPasswordOtpCheckCode(
          form: ForgetPasswordOtpCheckCodeFormX(
            email: email,
            otpCode: otpCode.text,
          ),
        );

        /// The time delay here is aesthetically beneficial
        buttonState.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
        );

        Get.offAndToNamed(RouteNameX.forgotPasswordReset,arguments: user);

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
    }
  }

  /// Resend the code and set a new timer
  void onResend() async {
    isLoadingResendAgain.value = true;
    error.value = null;
    try {
      String message = (await DatabaseX.forgetPassword(email: email))??'Verification code has been resent successfully';
      isResendAgain.value = false;
      startTimer();
      if (message.isNotEmpty) {
        ToastX.success(message: message);
      }
    } catch (e) {
      error.value = e.toErrorX;
      error.value!.log();
      ToastX.error(message: error);
    }
    isLoadingResendAgain.value = false;
  }

  /// A timer to calculate the time remaining until the code can be re-sent
  startTimer() {
    if (!isResendAgain.value) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (start.value != 0) {
          start--;
        } else {
          start.value = 60;
          isResendAgain.value = true;
          timer.cancel();
        }
      });
    }
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();

    /// Start the counter to resend the code
    startTimer();
  }

  /// Disable listeners
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
