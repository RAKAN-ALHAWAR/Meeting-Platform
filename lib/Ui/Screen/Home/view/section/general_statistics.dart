import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../Section/generalStatistics.dart';
import '../../../../Widget/Custom/Other/sectionTitle.dart';
import '../../controller/controller.dart';

class GeneralStatisticsForHome extends GetView<HomeController> {
  const GeneralStatisticsForHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title
        const SectionTitleX(title: 'General statistics').fadeAnimation500,

        /// Statistics Card
        GeneralStatisticsSectionX(
          statistics: controller.dashboard.statistics,
        ).fadeAnimation550,
      ],
    );
  }
}
