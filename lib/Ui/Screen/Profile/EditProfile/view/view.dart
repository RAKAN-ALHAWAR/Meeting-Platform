import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';
import 'Sections/input.dart';
import 'Sections/profileImage.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    controller.formKey=formKey;
    return Scaffold(
      appBar: const AppBarX(title: "My personal data"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
            vertical: StyleX.vPaddingApp,
          ),
          child: Column(
            children: [
              /// Image Input
              const ProfileImageSectionX(),

              const SizedBox(height: 24),

              /// Card Inputs
              const InputSectionX(),
              const SizedBox(height: 20),

              /// Save & Cancel Buttons
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ButtonStateX(
                        state: controller.buttonState.value,
                        onTap: controller.onEdit,
                        text: "Save",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ButtonX.gray(
                      onTap: () => Get.back(),
                      text: "Cancel",
                    ),
                  ),
                ],
              ).fadeAnimation450
            ],
          ),
        ),
      ),
    );
  }
}
