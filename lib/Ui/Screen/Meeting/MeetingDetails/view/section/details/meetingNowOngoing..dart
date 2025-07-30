import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/UI/Widget/widget.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../Config/config.dart';
import '../../../controller/controller.dart';

class MeetingNowOngoing extends GetView<MeetingDetailsController> {
  const MeetingNowOngoing({super.key});
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 14, top: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Ongoing Icon
              AnimatedBuilder(
                animation: controller.ongoingAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: controller.ongoingAnimation.value,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: ColorX.red.shade100,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: ColorX.red.shade600,
                      ),
                    ),
                  );
                },
              ),

              /// Space
              const SizedBox(width: 8),

              /// Title
              TextX(
                'The meeting is now ongoing',
                fontWeight: FontWeight.w600,
                color: ColorX.red.shade600,
              ),
            ],
          ).fadeAnimation250,

          /// Space
          const SizedBox(width: 5),

          /// Join here Button
          if (controller.meeting.value.locationOnlineUrl != null)
            ButtonX(
              text: 'Join here',
              onTap: controller.openMeeting,
              iconData: DeviseX.isLTR
                  ? Iconsax.arrow_circle_right
                  : Iconsax.arrow_circle_left,
              isTextFirst: true,
              marginVertical: 0,
            ).marginOnly(top: 12).fadeAnimation300
        ],
      ),
    ).fadeAnimation200;
  }
}
