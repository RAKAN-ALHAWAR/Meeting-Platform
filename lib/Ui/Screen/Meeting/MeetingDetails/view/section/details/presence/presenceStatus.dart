import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../controller/controller.dart';
import 'absentFromMeeting.dart';
import 'delegatedToSomeoneElse.dart';
import 'excusedCommentsForm.dart';
import 'headerPresence.dart';
import 'meetingAttended.dart';
import 'non_attendance_meeting.dart';
import 'present/presentCard.dart';
import 'saveButton.dart';
import 'selectionDelegate.dart';
import 'statusButtons.dart';

class PresenceStatus extends GetView<MeetingDetailsController> {
  const PresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ContainerX(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title & Edit Button
            const HeaderPresenceStatus(),

            /// Status Buttons Presence
            if (controller.isShowPresenceStatusButtons)
              const StatusButtonsPresenceStatus(),

            /// Form of Excused Comments
            if (controller.isShowPresenceStatusButtons &&
                controller.selectedPresenceStatus.value == 1)
              const ExcusedCommentFormPresenceStatus(),

            /// Select Delegated
            if (controller.isShowPresenceStatusButtons &&
                controller.selectedPresenceStatus.value == 2)
              const SelectionDelegatedPresenceStatus(),

            /// Non-attendance Meeting
            if (controller.isShowNonAttendanceMeetingPresenceStatus)
              const NonAttendanceMeetingPresenceStatus(),

            /// The meeting starts after
            if (controller.isShowPresentCardPresenceStatus)
              const PresentCardPresenceStatus(),

            /// Meeting Attended
            if (controller.isShowMeetingAttendedPresenceStatus)
              const MeetingAttendedPresenceStatus(),

            /// Absent From Meeting
            if (controller.isShowAbsentFromMeetingPresenceStatus)
              const AbsentFromMeetingPresenceStatus(),

            /// Delegated Details
            if (controller.isShowDelegatedToSomeoneElsePresenceStatus)
              const DelegatedToSomeoneElsePresenceStatus(),

            /// Save presence status button
            if (controller.isShowPresenceStatusButtons &&
                controller.selectedPresenceStatus.value != -1)
              const SaveButtonPresenceStatus(),
          ],
        ),
      ).fadeAnimation250,
    );
  }
}
