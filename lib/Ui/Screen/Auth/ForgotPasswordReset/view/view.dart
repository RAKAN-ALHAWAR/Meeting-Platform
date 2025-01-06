import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../Core/core.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../AuthLayout/authLayout.dart';
import '../controller/controller.dart';

class ForgotPasswordResetView extends GetView<ForgotPasswordResetController> {
  const ForgotPasswordResetView({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthLayoutX(
      title: 'Set a new password',
      subtitle: 'Please enter a new password',
      child: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            children: [
              /// Input Fields
              Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldX(
                      label: "New Password",
                      controller: controller.password,
                      validate: ValidateX.password,
                      hint: '',
                      isPassword: true,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      color: Get.theme.cardTheme.color,
                    ).marginOnly(top: 2).fadeAnimation250,
                    TextFieldX(
                      label: "Confirm new password",
                      controller: controller.rePassword,
                      validate: (val) => ValidateX.rePassword(
                        val,
                        controller.password.text,
                      ),
                      hint: '',
                      isPassword: true,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      color: Get.theme.cardTheme.color,
                    ).marginOnly(top: 2).fadeAnimation300,
                  ],
                ),
              ).marginOnly(bottom: 24),

              /// Button Login
              ButtonStateX(
                onTap: controller.onChangePassword,
                state: controller.buttonState.value,
                text: 'Save',
              ).fadeAnimation600,
            ],
          ),
        ),
      ),
    );
  }
}
