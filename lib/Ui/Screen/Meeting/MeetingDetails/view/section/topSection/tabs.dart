import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../controller/controller.dart';

class TabsSection extends GetView<MeetingDetailsController> {
  const TabsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      /// Tabs Sections
      () => TabSegmentX(
        controller: controller.tabs,
        tabs: {
          1: 'The details'.tr,
          2: 'Tasks & Tips'.tr,
          if (controller.meeting.value.isVote) 3: 'Voting'.tr,
          if (controller.meeting.value.isSuggestion) 4: 'Suggestions'.tr,
        },
      ).fadeAnimation300,
    );
  }
}
