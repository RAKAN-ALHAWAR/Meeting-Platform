import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Basic/Utils/future_builder.dart';
import '../controller/controller.dart';
import 'section/details/detailsSection.dart';
import 'section/loading/loading.dart';
import 'section/suggestions/suggestionsSection.dart';
import 'section/tasksAndTips/tasksAndTipsSection.dart';
import 'section/topSection/meetingBasicData.dart';
import 'section/topSection/tabs.dart';
import 'section/voting/votingSection.dart';

class MeetingDetailsView extends GetView<MeetingDetailsController> {
  const MeetingDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Meeting Details'),
      body: SafeArea(
        /// Get Meeting Data
        child: FutureBuilderX(
          future: controller.getData,
          loading: const LoadingSectionForMeetingDetails(),
          child: (data) {
            return SingleChildScrollView(
              padding: StyleX.paddingApp,
              child: Obx(
                () => AbsorbPointer(
                  absorbing: controller.isLoading.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// The top card containing the basic data for the meeting.
                      /// state, title, date, time, place
                      const MeetingBasicDataSection(),
                      const SizedBox(height: 16),

                      /// Sections tags
                      const TabsSection(),
                      const SizedBox(height: 16),

                      /// Details Section
                      if (controller.tabsIndex.value == 1)
                        const DetailsSection(),

                      /// Tasks & Tips Section
                      if (controller.tabsIndex.value == 2)
                        const TasksAndTipsSection(),

                      /// Voting Section
                      if (controller.tabsIndex.value == 3)
                        const VotingSection(),

                      /// Suggestions Section
                      if (controller.tabsIndex.value == 4)
                        const SuggestionsSection(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
