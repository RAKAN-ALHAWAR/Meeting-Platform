import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Data/Model/meeting/meeting.dart';
import 'package:meeting/Data/data.dart';

import '../../../../../Config/config.dart';
import '../../../../../Data/Enum/meeting_status_status.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';

class AllMeetingsController extends GetxController {
  //============================================================================
  // Variables

  List<String> tags = ['All meetings', 'Periodic meetings', 'Meetings ended'];
  late RxInt selectedTag = 0.obs;
  GlobalKey<ScrollRefreshLoadMoreXState> scrollRefreshLoadMoreKey =
      GlobalKey<ScrollRefreshLoadMoreXState>();

  //============================================================================
  // Functions

  Future<List<MeetingX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    if(selectedTag.value == 1){
      return await DatabaseX.getAllRecurringMeetings(
        page: data.page,
        perPage: data.perPage,
      );
    }else{
      return await DatabaseX.getAllMyMeetings(
        page: data.page,
        perPage: data.perPage,
        status: selectedTag.value==2?MeetingStatusStatusX.closed:null,
      );
    }
  }

  onChangeTag(int index) {
    selectedTag.value = index;
    scrollRefreshLoadMoreKey.currentState?.refresh();
    update();
  }

  onMeetingDetails(MeetingX meeting) =>
      Get.toNamed(RouteNameX.meetingDetails, arguments: meeting.id);
}
