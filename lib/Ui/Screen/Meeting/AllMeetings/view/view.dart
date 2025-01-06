import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Screen/Meeting/AllMeetings/view/section/tags.dart';

import '../../../../../UI/Animation/animation.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/Custom/Card/meetingCard.dart';
import '../controller/controller.dart';

class AllMeetingsView extends GetView<AllMeetingsController> {
  const AllMeetingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TagsSectionForAllMeetings(),
          GetBuilder<AllMeetingsController>(
            builder: (controller) => ScrollRefreshLoadMoreX(
              key: controller.scrollRefreshLoadMoreKey,
              fetchData: controller.getData,
              padding: const EdgeInsets.only(
                right: StyleX.hPaddingApp,
                left: StyleX.hPaddingApp,
                top: 4,
                bottom: 16
              ),
              initLoading: SingleChildScrollView(
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
              pageSize: 15,
              emptyMessage: 'There are no meetings.',
              itemBuilder: (data, index) {
                return MeetingCardX(
                  meeting: data,
                  onTap: controller.onMeetingDetails,
                ).fadeAnimation100;
              },
            ),
          )
        ],
      ),
    );
  }
}
