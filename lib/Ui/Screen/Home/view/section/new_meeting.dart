import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Custom/Card/meetingCard.dart';
import '../../../../Widget/Custom/Other/sectionTitle.dart';
import '../../controller/controller.dart';

class NewMeetingSectionForHome extends GetView<HomeController> {
  const NewMeetingSectionForHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title
        SectionTitleX(
          title: 'Upcoming meetings',
          showMore: controller.dashboard.newMeetings.length > 2
              ? controller.onUpcomingMeetings
              : null,
        ).fadeAnimation200,

        /// New Meetings Cards
        if (controller.dashboard.newMeetings.isNotEmpty)
          ...controller.dashboard.newMeetings.take(3).map(
                (meeting) => MeetingCardX(
              meeting: meeting,
              onTap: controller.onMeetingDetails,
            ).fadeAnimation250,
          ),

        /// Empty Message
        if (controller.dashboard.newMeetings.isEmpty)
          ContainerX(
            width: double.infinity,
            isBorder: true,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Iconsax.calendar_1,
                  color: Get.theme.colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                TextX(
                  'There are no new meetings.',
                  style: TextStyleX.supTitleLarge,
                  size: 14,
                ),
              ],
            ),
          ).fadeAnimation250,
      ],
    );
  }
}
