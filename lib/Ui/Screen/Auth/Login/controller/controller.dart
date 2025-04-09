import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meeting/Core/Extension/convert/convert.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Model/auth/otp.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> buttonGoogleState = ButtonStateEX.normal.obs;

  // RxBool isEmail = true.obs;
  RxBool isPhone = true.obs;
  final loginVia = ValueNotifier(1);
  Rx<ErrorX?> error = Rx<ErrorX?>(null);
  RxInt countryCode = 966.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController idNumber = TextEditingController();

  //============================================================================
  // Functions

  onTapError() {}
  onChangeCountryCode(String code) => countryCode.value = int.parse(code);


  Future<void> onLogin() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        error.value = null;
        try {
          // if (isEmail.value) {
          //   await loginByEmail();
          // }
          if (isPhone.value) {
            await loginByPhone();
          }else {
            await loginByIdNumber();
          }

          if(!isPhone.value) {
            /// The time delay here is aesthetically beneficial
            buttonState.value = ButtonStateEX.success;
            await Future.delayed(
              const Duration(seconds: StyleX.successButtonSecond),
            );

            Get.offAndToNamed(RouteNameX.root);
          }

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

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:  "451124782998-c10f0kag25irg5c4p0a46h499b8cnhut.apps.googleusercontent.com",
    serverClientId: "451124782998-c10f0kag25irg5c4p0a46h499b8cnhut.apps.googleusercontent.com",
  );


  Future<void> sendAuthCodeToBackend(String authCode) async {
    final response = await http.post(
      Uri.parse("https://meeting.edialoguec.sa/api/auth/google"),
      body: {'code': authCode},
    );

    if (response.statusCode == 200) {
      print("تمت المصادقة بنجاح مع الباك اند!");
      print(response.body);
    } else {
      print("فشل المصادقة مع الباك اند: ${response.body}");
    }
  }
  onLoginByGoogle()async{
    if (isLoading.isFalse) {
      isLoading.value = true;
      buttonGoogleState.value = ButtonStateEX.loading;
      error.value = null;
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          print("تم إلغاء تسجيل الدخول");
          buttonGoogleState.value = ButtonStateEX.normal;
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final String? authCode = googleAuth.serverAuthCode;
        if (authCode != null) {
          print("تم الحصول على Auth Code: $authCode");

          // إرسال الكود إلى الباك اند
          await sendAuthCodeToBackend(authCode);
        }
        /// The time delay here is aesthetically beneficial
        buttonGoogleState.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
        );
      } catch (e) {
        error.value = e.toErrorX;
        error.value!.log();
        buttonGoogleState.value = ButtonStateEX.failed;
        ToastX.error(message: error);
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
            () {
          buttonGoogleState.value = ButtonStateEX.normal;
        },
      );

      // try {
      //   var x = await DatabaseX.loginByGoogle();
      //   _googleSignIn = GoogleSignIn(
      //     clientId: Uri.parse(x??'').queryParameters['client_id'],
      //   );
      //   print(x);
      //   print(Uri.parse(x??'').queryParameters['client_id']);
      //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      //   if (googleUser != null) {
      //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      //     print(googleAuth.accessToken);
      //     print(googleAuth.idToken);
      //   }
      // } catch (error) {
      //   print('حدث خطأ: $error');
      // }
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

  Future<String?> loginByPhone() async {
    String? massage = await DatabaseX.loginByPhone(
      phone: phone.text.toIntX, countryCode: countryCode.value,
    );

    if(massage!=null){
      ToastX.success(message: massage);
    }

    /// The time delay here is aesthetically beneficial
    buttonState.value = ButtonStateEX.success;
    await Future.delayed(
      const Duration(seconds: StyleX.successButtonSecond),
    );

    /// create otp object
    OtpX otp = OtpX(
      phone: phone.text.toIntX,
      countryCode: countryCode.value,
      isLogin: true,
      isPhone: true,
    );

    Get.toNamed(RouteNameX.otp, arguments: otp);
    return massage;
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
      // isEmail.value = loginVia.value == 1;
      isPhone.value = loginVia.value == 1;
    });
  }
}
