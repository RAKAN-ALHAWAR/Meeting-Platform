import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';

import '../../../../../../../Widget/widget.dart';
import '../../../../controller/controller.dart';

class NonAttendanceMeetingPresenceStatus
    extends GetView<MeetingDetailsController> {
  const NonAttendanceMeetingPresenceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Message
        Obx(
          () => MessageCardX(
            color: ColorX.red,
            icon: Iconsax.close_circle,
            text: controller.isClosedMeeting.value
                ? 'You did not attend this meeting'
                : 'I will not attend the meeting',
          ),
        ).fadeAnimation250,
        const SizedBox(height: 10),

        /// Title of Reason for not attending
        const TextX(
          'Reason for not attending',
          fontWeight: FontWeight.w700,
        ).fadeAnimation300,
        const SizedBox(height: 6),

        /// Reason for not attending
        TextX(
          controller.myAttendance.value?.comments ?? '',
          style: TextStyleX.titleSmall,
          color: ColorX.grey.shade500,
        ).fadeAnimation350,
      ],
    );
  }
}
