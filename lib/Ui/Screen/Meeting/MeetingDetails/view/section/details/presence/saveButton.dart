import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../controller/controller.dart';

class SaveButtonPresenceStatus extends GetView<MeetingDetailsController> {
  const SaveButtonPresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      /// Disable of Button
      () => AbsorbPointer(
        absorbing: controller.isDisableButtonOfSavePresenceStatus,

        /// Change Opacity of Button
        child: Opacity(
          opacity: controller.isDisableButtonOfSavePresenceStatus ? 0.5 : 1,

          /// Save Button
          child: ButtonStateX.second(
            text: 'Save status',
            state: controller.buttonStatePresenceStatus.value,
            onTap: controller.onSendPresenceStatus,
          ).marginOnly(top: 12).fadeAnimation350,
        ),
      ),
    );
  }
}
