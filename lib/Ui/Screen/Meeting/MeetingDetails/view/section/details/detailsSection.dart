import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../Data/Enum/attendance_status_status.dart';
import '../../../controller/controller.dart';
import 'attachmentsSection.dart';
import 'descriptionAndAgendaAndAttendances.dart';
import 'meetingNowOngoing..dart';
import 'presence/presenceStatus.dart';

class DetailsSection extends GetView<MeetingDetailsController> {
  const DetailsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            /// Presence Status
            if (controller.myAttendance.value!=null && (controller.isOngoingMeeting.isFalse ||
                controller.myAttendance.value?.status != AttendanceStatusStatusX.present))
              const PresenceStatus(),
            /// Now Ongoing
            if (controller.myAttendance.value!=null && controller.isOngoingMeeting.isTrue &&
                controller.myAttendance.value?.status == AttendanceStatusStatusX.present)
              const MeetingNowOngoing(),

            /// Space
            if(controller.myAttendance.value!=null)
            const SizedBox(height: 16),

            /// Description & Agenda & Attendances
            const DescriptionAndAgendaAndAttendances(),

            /// Attachments (Files)
            if (controller.meeting.value.attachments.isNotEmpty)
              const AttachmentsSection().marginOnly(top: 16),
          ],
        );
      },
    );
  }
}
