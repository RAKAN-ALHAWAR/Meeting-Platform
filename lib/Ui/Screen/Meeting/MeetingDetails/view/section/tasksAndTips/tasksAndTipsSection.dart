import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../controller/controller.dart';

class TasksAndTipsSection extends GetView<MeetingDetailsController> {
  const TasksAndTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title for preparatory tasks section
              TextX(
                'Preparatory tasks for the meeting',
                style: TextStyleX.titleLarge,
                size: 16,
              ).fadeAnimation200,
              const SizedBox(height: 10),

              /// Preparatory tasks list
              if (controller.meeting.value.tasks.isNotEmpty)
                AbsorbPointer(
                  absorbing: controller.meeting.value.isClosed,
                  child: Opacity(
                    opacity: controller.meeting.value.isClosed ? 0.5 : 1,
                    child: Column(
                      children: [
                        for (var x in controller.meeting.value.tasks)

                          /// Task item with a checkbox
                          CheckBoxX(
                            value: false,
                            label: x.content,
                            strikethroughOnChecked: true,
                            color: Theme.of(context).cardColor,
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            onChanged: controller.onChangeTask,
                            textStyle: TextStyleX.titleSmall,
                          ).fadeAnimation250,
                      ],
                    ),
                  ),
                ),

              /// Message if no preparatory tasks are available
              if (controller.meeting.value.tasks.isEmpty)
                TextX(
                  'There are no preparatory tasks for this meeting.',
                  style: TextStyleX.titleSmall,
                  color: ColorX.grey.shade600,
                ).fadeAnimation250,
              const SizedBox(height: 18),

              /// Title for general recommendations section
              TextX(
                'General Recommendations',
                style: TextStyleX.titleLarge,
                size: 16,
              ).fadeAnimation300,
              const SizedBox(height: 10),

              /// List of general recommendations
              if (controller.isShowGeneralRecommendations)
                Column(
                  children: [
                    for (var x in controller.meeting.value.agendas
                        .where((x) => x.recommendContent != null))

                      /// General recommendation item
                      ContainerX(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        width: double.maxFinite,
                        child: TextX(
                          x.recommendContent!,
                          style: TextStyleX.titleSmall,
                        ),
                      ).fadeAnimation350,
                  ],
                ),

              /// Message if general recommendations will appear later
              if (!controller.meeting.value.isClosed)
                MessageCardX(
                  color: ColorX.blue,
                  icon: Iconsax.info_circle,
                  text:
                      'Recommendations will appear here after the meeting ends',
                ).fadeAnimation350,

              /// Message if no general recommendations are available after meeting
              if (controller.meeting.value.isClosed &&
                  controller.meeting.value.agendas
                      .where((x) => x.recommendContent != null)
                      .isEmpty)
                TextX(
                  'There are no recommendations from this meeting.',
                  style: TextStyleX.titleSmall,
                  color: ColorX.grey.shade600,
                ).fadeAnimation450,
              const SizedBox(height: 18),

              /// Title for recommendations assigned to the user
              TextX(
                'Recommendations Assigned to You',
                style: TextStyleX.titleLarge,
                size: 16,
              ).fadeAnimation400,
              const SizedBox(height: 10),

              /// Message if recommendations assigned to the user will appear later
              if (!controller.meeting.value.isClosed)
                MessageCardX(
                  color: ColorX.blue,
                  icon: Iconsax.info_circle,
                  text:
                      'Recommendations will appear here after the meeting ends',
                ).fadeAnimation450,

              /// TODO: فحص اذا كان هناك توصيات مسندة اليك وعرضها
              if (controller.meeting.value.isClosed)
                TextX(
                  'There are no recommendations assigned to you from this meeting.',
                  style: TextStyleX.titleSmall,
                  color: ColorX.grey.shade600,
                ).fadeAnimation450,
            ],
          ),
        );
      },
    );
  }
}
