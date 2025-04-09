import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../../../../../Config/config.dart';
import '../../../../../controller/controller.dart';
import 'countdownToMeetingStartTime.dart';

class PresentCardPresenceStatus extends GetView<MeetingDetailsController> {
  const PresentCardPresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          /// Message
          MessageCardX(
            color: ColorX.green,
            text: 'I will attend the meeting',
            icon: Iconsax.tick_circle,
          ).fadeAnimation250,

          /// Countdown
          if (controller.isUpcomingMeeting.isTrue)
            const CountdownToMeetingStartTime().fadeAnimation300,


        ],
      ),
    );
  }
}
