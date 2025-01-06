import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../Core/core.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../AuthLayout/authLayout.dart';
import '../controller/controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthLayoutX(
      title: 'Recover password',
      subtitle: 'Please enter your email and click submit',
      child: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            children: [
              Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidate,
                child: TextFieldX(
                  label: "Your email",
                  controller: controller.email,
                  validate: ValidateX.email,
                  hint: '',
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  color: Get.theme.cardTheme.color,
                ).marginSymmetric(vertical: 2).fadeAnimation250,
              ).marginOnly(bottom: 24),

              /// Button Login
              ButtonStateX(
                onTap: controller.onSend,
                state: controller.buttonState.value,
                text: 'Send',
              ).fadeAnimation300,
            ],
          ),
        ),
      ),
    );
  }
}
