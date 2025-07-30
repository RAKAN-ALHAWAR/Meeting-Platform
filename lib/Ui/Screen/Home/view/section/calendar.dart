import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Custom/Other/sectionTitle.dart';
import '../../controller/controller.dart';

class CalendarSectionForHome extends GetView<HomeController> {
  const CalendarSectionForHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title
        const SectionTitleX(title: 'Calendar').fadeAnimation400,

        /// Calendar
        ContainerX(
          isBorder: true,
          radius: StyleX.radiusLg,
          child: DatePickerX(
            readOnly: true,
            onDateSelected: controller.onDateSelectedCalendar,
            selectedDates: controller.datesOfCalendar,
            weekColor: Get.textTheme.bodyMedium?.color,
            dayColor: ColorX.grey.shade400,
            dayDisabledColor: ColorX.grey.shade300,
            dayPadding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
            dayMargin: const EdgeInsets.symmetric(horizontal: 4),
            selectedDayBackgroundRadius: BorderRadius.circular(50),
            todayBackgroundRadius: BorderRadius.circular(50),
            selectedDayBackgroundColor: ColorX.primary.shade500,
            nextIcon: Icons.arrow_forward_ios_rounded,
            lastIcon: Icons.arrow_back_ios_new_rounded,
          ),
        ).fadeAnimation450,
      ],
    );
  }
}
