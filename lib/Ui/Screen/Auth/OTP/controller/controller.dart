import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meeting/Data/Form/Auth/forget_password_otp_check_code.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Form/auth/phone_otp_check_code.dart';
import '../../../../../Data/Model/User/user.dart';
import '../../../../../Data/Model/auth/otp.dart';
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

  OtpX otp = Get.arguments;

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
  /// Some titles have been duplicated if the title has changed in any case
  String getSubTitle() {
    if (otp.isPhone) {
      return "Please enter the confirmation code sent to your mobile number to complete the process.";
    }else{
      return "Please enter the confirmation code sent to your email to complete the process";
    }
  }

  onVerify() async {
    if (isLoading.isFalse) {
      isLoading.value = true;
      buttonState.value = ButtonStateEX.loading;
      error.value = null;
      try {
        late UserX user;

        if(otp.isPhone){
          user = await DatabaseX.phoneOtpCheckCode(
            form: PhoneOtpCheckCodeFormX(
              phone: otp.phone!,
              countryCode: otp.countryCode!,
              otpCode: otpCode.text,
            ),
          );
        }else{
          user = await DatabaseX.forgetPasswordOtpCheckCode(
            form: ForgetPasswordOtpCheckCodeFormX(
              email: otp.email!,
              otpCode: otpCode.text,
            ),
          );
        }

        /// The time delay here is aesthetically beneficial
        buttonState.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
        );

        if(otp.isPhone && otp.isLogin){
          app.user =user.obs;

          /// save data on local
          LocalDataX.put(LocalKeyX.token, app.user.value.token);
          LocalDataX.put(LocalKeyX.route, RouteNameX.root);
          Get.offAndToNamed(RouteNameX.root);

        }else{
          Get.offAndToNamed(RouteNameX.forgotPasswordReset,arguments: user);
        }

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
      String message = await sendCode() ?? '';
      isResendAgain.value = false;
      startTimer();
      if (message.isNotEmpty) {
        ToastX.success(message: message);
      }
    } catch (e) {
      error.value = e.toErrorX;
    }
    isLoadingResendAgain.value = false;
  }

  /// use api from backend to send code otp
  sendCode() async {
    try {
      if (otp.isPhone) {
        return await DatabaseX.loginByPhone(
          phone: otp.phone!,
          countryCode: otp.countryCode!,
        );
      } else {
        return await DatabaseX.forgetPassword(email: otp.email!);
      }
    } catch (e) {
      rethrow;
    }
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
