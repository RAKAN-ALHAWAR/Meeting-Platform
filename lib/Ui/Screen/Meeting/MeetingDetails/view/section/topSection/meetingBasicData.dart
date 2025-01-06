import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Other/meetingState.dart';
import '../../../../../../../Config/Translation/translation.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../controller/controller.dart';

class MeetingBasicDataSection extends GetView<MeetingDetailsController> {
  const MeetingBasicDataSection({super.key});
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Meeting State
          MeetingStateX(
            meeting: controller.meeting.value,
          ).fadeAnimation50,

          /// Title
          TextX(
            controller.meeting.value.title,
            style: TextStyleX.titleLarge,
            maxLines: 2,
          ).marginSymmetric(vertical: 12).fadeAnimation100,

          /// Data
          Row(
            children: [
              Icon(
                Iconsax.calendar_1,
                color: ColorX.grey.shade400,
                size: 20,
              ),
              const SizedBox(width: 10),
              TextX(
                DateFormat(
                  'EEEE, d MMMM yyyy',
                  TranslationX.getLanguageCode,
                ).format(controller.meeting.value.date),
                color: ColorX.grey.shade500,
                fontWeight: FontWeight.w400,
                size: 14,
              ),
            ],
          ).fadeAnimation150,

          /// Time
          Row(
            children: [
              Icon(
                Iconsax.clock,
                color: ColorX.grey.shade400,
                size: 18,
              ),
              const SizedBox(width: 10),
              TextX(
                '${DateFormat('hh:mm a', TranslationX.getLanguageCode).format(controller.meeting.value.startAt.toDateTimeX)} - ${DateFormat('hh:mm a', TranslationX.getLanguageCode).format(controller.meeting.value.endAt.toDateTimeX)}',
                color: ColorX.grey.shade500,
                fontWeight: FontWeight.w400,
                size: 14,
              ),
            ],
          ).marginSymmetric(vertical: 12).fadeAnimation200,

          /// Meeting Place
          Row(
            children: [
              Icon(
                Iconsax.video,
                color: ColorX.grey.shade400,
                size: 18,
              ),
              const SizedBox(width: 10),
              TextX(
                controller.meeting.value.place.name,
                color: ColorX.grey.shade500,
                fontWeight: FontWeight.w400,
                size: 14,
              ),
            ],
          ).fadeAnimation250,
        ],
      ),
    ).fadeAnimation50;
  }
}
