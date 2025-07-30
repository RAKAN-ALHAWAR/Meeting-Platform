import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/controller.dart';

class InputSectionX extends GetView<EditProfileController> {
  const InputSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      width: double.maxFinite,
      child: Form(
        key: controller.formKey,
        autovalidateMode: controller.autoValidate,
        child: Column(
          children: [
            TextFieldX(
              controller: controller.name,
              label: "Name",
              isRequired: true,
              validate: ValidateX.name,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ).fadeAnimation200,
            TextFieldX(
              label: "ID Number",
              controller: controller.idNumber,
              validate: ValidateX.idNumber,
              isRequired: true,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              color: Get.theme.cardTheme.color,
            ).marginSymmetric(vertical: 10.0).fadeAnimation250,
            TextFieldX(
              controller: controller.email,
              label: "Email",
              isRequired: true,
              onlyRead: true,
              color: ColorX.grey.shade50.withOpacity(0.4),
              validate: ValidateX.email,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
            ).fadeAnimation300,
            PhoneFieldX(
              controller: controller.phone,
              label: "Mobile Number",
              isRequired: true,
              onChangeCountryCode: controller.onChangeCountryCode,
              countryCode: controller.countryCode,
            ).marginSymmetric(vertical: 10.0).fadeAnimation300,

            TextFieldX(
              controller: controller.category,
              label: "Category",
              onlyRead: true,
              color: ColorX.grey.shade50.withOpacity(0.4),
              // validate: ValidateX.name,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ).fadeAnimation350,

            TextFieldX(
              controller: controller.jobTitle,
              label: "Job Title",
              onlyRead: true,
              color: ColorX.grey.shade50.withOpacity(0.4),
              // validate: ValidateX.name,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.done,
            ).marginOnly(top: 10.0).fadeAnimation400,
          ],
        ),
      ),
    );
  }
}
