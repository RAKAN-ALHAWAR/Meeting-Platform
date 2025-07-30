import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../../../../Config/config.dart';
import '../../../../../../../../Core/core.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../controller/controller.dart';

class AbsentFromMeetingPresenceStatus
    extends GetView<MeetingDetailsController> {
  const AbsentFromMeetingPresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Message
        const MessageCardX(
          color: ColorX.red,
          icon: Iconsax.close_circle,
          text: 'Absent from this meeting',
        ).fadeAnimation250,
        const SizedBox(height: 16),

        /// Button for view meeting minutes
        ButtonX(
          text: 'View meeting minutes',
          onTap: controller.openMinutesMeeting,
          isTextFirst: true,
          marginVertical: 0,
          iconData: DeviseX.isLTR
              ? Iconsax.arrow_circle_right
              : Iconsax.arrow_circle_left,
        ).fadeAnimation300,
      ],
    );
  }
}
