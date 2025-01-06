import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Screen/Home/view/section/appBar.dart';
import 'package:meeting/Ui/Screen/Home/view/section/new_meeting.dart';
import 'package:meeting/Ui/Screen/Home/view/section/tasks.dart';
import 'package:meeting/Ui/Widget/Basic/Utils/future_builder.dart';

import '../../../../Config/config.dart';
import '../../../../UI/Animation/animation.dart';
import '../controller/controller.dart';
import 'section/calendar.dart';
import 'section/general_statistics.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Name & Notification
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBarForHome(),
      ),
      /// Content
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
            vertical: 10,
          ),
          child: FutureBuilderX(
            future: controller.getData,
            loading: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < 10; i++)
                    const ShimmerAnimationX(
                      height: 180,
                      margin: EdgeInsets.only(bottom: 10),
                    )
                ],
              ),
            ),
            child: (_) => const Column(
              children: [
                NewMeetingSectionForHome(),
                SizedBox(height: 16),
                TasksSectionForHome(),
                SizedBox(height: 16),
                CalendarSectionForHome(),
                SizedBox(height: 24),
                GeneralStatisticsForHome(),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
