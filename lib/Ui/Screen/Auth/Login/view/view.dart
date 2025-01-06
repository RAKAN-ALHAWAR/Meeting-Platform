import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Screen/Auth/AuthLayout/authLayout.dart';
import '../../../../../Core/core.dart';
import '../../../../../Config/config.dart';
import '../../../../Widget/widget.dart';
import '../controller/controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthLayoutX(
      isBackIcon: false,
      isShowLogo: false,
      title: 'Log in',
      subtitle: 'Welcome back, Sign in to your account',
      child: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Error Message
              // if (controller.error.value!=null)
              //   GestureDetector(
              //     onTap: controller.onTapError,
              //     child: MessageCardX(
              //       message: controller.error.value?.message,
              //       isError: true,
              //     ),
              //   ).marginOnly(bottom: 14).fadeAnimation200,

              /// Select registration method tab
              TabSegmentX(
                controller: controller.loginVia,
                tabs: {
                  1: 'Email'.tr,
                  2: 'ID Number'.tr,
                },
              ).fadeAnimation300.marginOnly(bottom: 16),

              /// Input Fields
              Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.isEmail.value)
                      TextFieldX(
                        key: const Key('Email'),
                        label: "Email",
                        controller: controller.email,
                        validate: ValidateX.email,
                        hint: '',
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ).marginSymmetric(vertical: 2).fadeAnimation400,
                    if (!controller.isEmail.value)
                      TextFieldX(
                        key: const Key('ID number'),
                        label: "Your ID number",
                        controller: controller.idNumber,
                        validate: ValidateX.idNumber,
                        hint: '',
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ).marginSymmetric(vertical: 2).fadeAnimation400,
                    TextFieldX(
                      label: "Password",
                      controller: controller.password,
                      validate: ValidateX.password,
                      hint: '',
                      isPassword: true,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      color: Get.theme.cardTheme.color,
                    ).marginOnly(top: 2).fadeAnimation500,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: controller.onForgotPassword,
                          borderRadius: BorderRadius.circular(StyleX.radius),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 5,
                            ),
                            child: TextX(
                              "Forgot your password?",
                              color: ColorX.primary.shade500,
                              style: TextStyleX.supTitleLarge,
                            ),
                          ),
                        ),
                      ],
                    ).fadeAnimation500,
                  ],
                ),
              ).marginOnly(bottom: 12),

              /// Button Login
              ButtonStateX(
                onTap: controller.onLogin,
                state: controller.buttonState.value,
                text: 'Log in',
              ).fadeAnimation600,

              const SizedBox(height: 30.0),

              /// Sponsor Logo
              Image.asset(
                ImageX.sponsorLogo,
                width: 50,
              ).fadeAnimation700,
            ],
          ),
        ),
      ),
    );
  }
}
