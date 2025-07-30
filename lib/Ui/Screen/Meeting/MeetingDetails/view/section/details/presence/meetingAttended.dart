import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../../../../Config/config.dart';
import '../../../../../../../../Core/core.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../controller/controller.dart';

class MeetingAttendedPresenceStatus extends GetView<MeetingDetailsController> {
  const MeetingAttendedPresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Message
        MessageCardX(
          color: ColorX.green,
          icon: Iconsax.tick_circle,
          text: 'The meeting was attended',
        ).fadeAnimation250,
        const SizedBox(height: 16),

        /// Button of meeting minutes
        ButtonX(
          text: 'View meeting minutes',
          onTap: controller.openMinutesMeeting,
          iconData: DeviseX.isLTR
              ? Iconsax.arrow_circle_right
              : Iconsax.arrow_circle_left,
          isTextFirst: true,
          marginVertical: 0,
        ).fadeAnimation300,
      ],
    );
  }
}
