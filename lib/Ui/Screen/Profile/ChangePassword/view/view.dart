import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    controller.formKey=formKey;
    return Scaffold(
      appBar: const AppBarX(title: "Change password"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: StyleX.vPaddingApp,
        ),
        child: Column(
          children: [
            ContainerX(
              width: double.maxFinite,
              child: Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidate,
                child: Column(
                  children: [
                    TextFieldX(
                      controller: controller.oldPassword,
                      label: "Old Password",
                      validate: ValidateX.password,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ).fadeAnimation200,
                    TextFieldX(
                      label: "New Password",
                      controller: controller.newPassword,
                      validate: ValidateX.password,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      color: Get.theme.cardTheme.color,
                    ).marginSymmetric(vertical: 10.0).fadeAnimation250,
                    TextFieldX(
                      controller: controller.reNewPassword,
                      label: "Confirm new password",
                      validate: (val)=>ValidateX.rePassword(val, controller.newPassword.text),
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ).fadeAnimation300,
                  ],
                ),
              ),
            ).fadeAnimation100,
            const SizedBox(height: 24),

            /// Save & Cancel Buttons
            Row(
              children: [
                Flexible(
                  child: Obx(
                        () => ButtonStateX(
                      state: controller.buttonState.value,
                      onTap: controller.onEdit,
                      text: "Save",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: ButtonX.gray(
                    onTap: () => Get.back(),
                    text: "Cancel",
                  ),
                ),
              ],
            ).fadeAnimation400
          ],
        ),
      ),
    );
  }
}
