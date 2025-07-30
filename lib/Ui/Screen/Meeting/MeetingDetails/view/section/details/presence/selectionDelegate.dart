import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../controller/controller.dart';

class SelectionDelegatedPresenceStatus extends GetView<MeetingDetailsController> {
  const SelectionDelegatedPresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      /// Selection Delegated User
      () => MultipleSelectionCardX(
        onTap: controller.onTapDelegateSelection,
        asInputField: controller.selectedDelegatedUser.value == null,
        title: controller.selectedDelegatedUser.value?.name ??
            "Select the client's name",
      ).marginOnly(top: 16).fadeAnimation250,
    );
  }
}
