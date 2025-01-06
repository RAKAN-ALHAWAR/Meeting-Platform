import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Custom/Card/taskCard.dart';
import '../../../../Widget/Custom/Other/sectionTitle.dart';
import '../../controller/controller.dart';

class TasksSectionForHome extends GetView<HomeController> {
  const TasksSectionForHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title
        const SectionTitleX(
          title: 'Tasks and recommendations assigned to you',
        ).fadeAnimation300,

        /// Tasks Cards
        if (controller.dashboard.tasks.isNotEmpty)
          ...controller.dashboard.tasks.map(
                (task) => TaskCardX(
              task: task,
              onTap: controller.onMeetingDetailsByTask,
            ).fadeAnimation350,
          ),

        /// Empty Tasks
        if (controller.dashboard.tasks.isEmpty)
          ContainerX(
            width: double.infinity,
            isBorder: true,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Iconsax.task_square,
                  color: Get.theme.colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                TextX(
                  'There are no tasks assigned to you.',
                  style: TextStyleX.supTitleLarge,
                  size: 14,
                ),
              ],
            ),
          ).fadeAnimation350,
      ],
    );
  }
}
