import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/Model/user/mini_user.dart';
import 'package:meeting/Data/data.dart';

import '../../Enum/delegate_status_status.dart';
import '../attendance/attendance.dart';

class DelegateX {
  final String id;
  final String attendanceId;
  final String delegateId;
  final String delegatedId;
  final String meetingId;
  late final DateTime attendedAt;
  final String? delegationFile;
  final DateTime? delegateDate;
  final DelegateStatusStatusX status;
  late final AttendanceX attendance;
  final MiniUserX? delegated;

  DelegateX({
    required this.id,
    required this.attendanceId,
    required this.delegateId,
    required this.delegatedId,
    required this.meetingId,
    required this.attendedAt,
    this.delegationFile,
    this.delegateDate,
    required this.status,
    this.delegated,
    required this.attendance,
  });
  DelegateX.local({
    this.id='',
    this.attendanceId='',
    this.delegateId='',
    this.delegatedId='',
    this.meetingId='',
    this.delegationFile,
    this.delegateDate,
    this.status = DelegateStatusStatusX.waitingForApproval,
    this.delegated,
  });

  factory DelegateX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> attendanceJson =
        Map<String, Object?>.from(json[NameX.attendance] ?? {});
    return ModelUtilX.checkFromJson(
      json,
      (json) => DelegateX(
        id: json[NameX.id].toStrX,
        attendanceId: json[NameX.attendanceId].toStrX,
        delegateId: json[NameX.delegateId].toStrX,
        delegatedId: json[NameX.delegatedId].toStrX,
        meetingId: json[NameX.meetingId].toStrX,
        attendedAt: json[NameX.attendedAt].toDateTimeX,
        delegationFile: json[NameX.delegationFile].toStrNullableX,
        delegateDate: json[NameX.delegateDate].toDateTimeNullableX,
        attendance: AttendanceX.fromJson(attendanceJson),
        delegated: json[NameX.delegated].toFromJsonNullableX(
          MiniUserX.fromJson,
        ),
        status: json[NameX.status].toBoolNullableX == true
            ? DelegateStatusStatusX.accepted
            : json[NameX.status].toBoolNullableX == false
                ? DelegateStatusStatusX.rejected
                : DelegateStatusStatusX.waitingForApproval,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.attendanceId,
        NameX.delegateId,
        NameX.delegatedId,
        NameX.meetingId,
        NameX.attendedAt,
        NameX.attendance,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.attendanceId: attendanceId,
      NameX.delegateId: delegateId,
      NameX.delegatedId: delegatedId,
      NameX.meetingId: meetingId,
      NameX.attendedAt: attendedAt.toIso8601String(),
      if (delegationFile != null) NameX.delegationFile: delegationFile,
      if (delegateDate != null)
        NameX.delegateDate: delegateDate?.toIso8601String(),
      NameX.status: status==DelegateStatusStatusX.accepted?true:status==DelegateStatusStatusX.rejected?false:null,
      NameX.attendance: attendance.toJson(),
      NameX.delegated: delegated?.toJson(),
    };
  }
}
