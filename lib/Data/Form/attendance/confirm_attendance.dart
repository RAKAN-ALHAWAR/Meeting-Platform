import 'package:meeting/Data/data.dart';
import '../../Enum/attendance_status_status.dart';

class ConfirmAttendanceFormX {
  final String attendanceId;
  final AttendanceStatusStatusX status;
  final String? delegatedUserId;
  final String? comments;

  ConfirmAttendanceFormX({
    required this.attendanceId,
    required this.status,
    this.delegatedUserId,
    this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.statusId: status.status.toString(),
      if(delegatedUserId!=null)
      NameX.delegatedId: delegatedUserId,
      if(comments!=null)
      NameX.comments: comments,
    };
  }
}
