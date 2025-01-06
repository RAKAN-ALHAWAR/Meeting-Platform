import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/UI/Widget/widget.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../controller/controller.dart';

class DescriptionAndAgendaAndAttendances
    extends GetView<MeetingDetailsController> {
  const DescriptionAndAgendaAndAttendances({super.key});
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Description
          if (controller.meeting.value.description.isNotEmpty)
            TextX(
              controller.meeting.value.description,
              fontWeight: FontWeight.w400,
            ).marginOnly(bottom: 20),

          /// Agenda Title
          const TextX(
            'Meeting agenda',
            fontWeight: FontWeight.w600,
          ).marginOnly(bottom: 6),

          /// Agenda Content
          for (int i = 0; i < controller.meeting.value.agendas.length; i++)
            TextX(
              '${i + 1}. ${controller.meeting.value.agendas[i].content} (${controller.meeting.value.agendas[i].duration} ${'minute'.tr}).',
              fontWeight: FontWeight.w400,
            ),
          const SizedBox(height: 16),

          /// Attendances Title
          const TextX(
            'The audience',
            fontWeight: FontWeight.w600,
          ).marginOnly(bottom: 6),

          /// Attendances Content
          for (int i = 0; i < controller.attendances.length; i++)
            TextX(
              controller.attendances[i].role?.name != null
                  ? '${i + 1}. ${controller.attendances[i].user?.name} - ${controller.attendances[i].role!.name}.'
                  : '${i + 1}. ${controller.attendances[i].user?.name}',
              fontWeight: FontWeight.w400,
            ),

          /// Space
          const SizedBox(height: 16),

          /// The End
          const TextX(
            'We wish you a fruitful meeting!',
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    ).fadeAnimation350;
  }
}
