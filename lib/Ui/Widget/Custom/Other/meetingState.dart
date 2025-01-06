import 'package:flutter/material.dart';
import '../../../../Config/config.dart';
import '../../../../Data/Enum/repetition_type_status.dart';
import '../../../../Data/Model/meeting/meeting.dart';
import '../../widget.dart';

class MeetingStateX extends StatelessWidget {
  const MeetingStateX({super.key, required this.meeting});
  final MeetingX meeting;
  @override
  Widget build(BuildContext context) {
    (String,MaterialColor) getMeetingStatus() {
      final now = DateTime.now();

      // إذا كان مغلق
      // if (meeting.isClosed) {
      //   return ('Closed', ColorX.red);
      // }

      // إذا كان مغلق (منتهي)
      if (meeting.isClosed) {
        return ('Ended', ColorX.grey);
      }

      // إذا كان دوري
      if (meeting.repetitionType != RepetitionTypeStatusX.once) {
        return ('Recurring', ColorX.blue);
      }

      // إذا كان التاريخ لم يأتي بعد
      if (meeting.startFullDate.isAfter(now)) {
        return ('Upcoming', ColorX.yellow);
      }

      // إذا كان الاجتماع ضمن الوقت الحالي
      if (meeting.startFullDate.isBefore(now) && meeting.endFullDate.isAfter(now)) {
        return ('Ongoing', ColorX.red);
      }

      // إذا كان التاريخ قديم (منتهي)
      // if (meeting.endFullDate.isBefore(now)) {
      //   return ('Ended', ColorX.grey);
      // }

      // في حالة أخرى
      return ('Open', ColorX.green);
      // return ('Other', ColorX.yellow);
    }
    var x = getMeetingStatus();
    return ContainerX(
      isBorder: true,
      color: x.$2.shade50,
      borderColor: x.$2.shade300,
      radius: 100,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      child: TextX(
        x.$1,
        style: TextStyleX.supTitleLarge,
        color: x.$2.shade500,
      ),
    );
  }
}
