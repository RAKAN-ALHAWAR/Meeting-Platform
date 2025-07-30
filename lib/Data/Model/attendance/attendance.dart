import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/Model/meeting/mini_meeting.dart';
import 'package:meeting/Data/data.dart';

import '../../Enum/attendance_status_status.dart';
import '../User/role.dart';
import '../User/user.dart';
import '../user/permission.dart';

class AttendanceX {
  String id;
  String meetingId;
  String userId;
  String? userRoleName;
  /// اذا تم ارسال دعوة
  bool invitationSent;
  /// التعليقات
  String? comments;
  DateTime? attendedAt;
  String? signature;
  bool isOpen;
  bool isVote;
  bool isVoteDelegate;
  DateTime? createdAt;
  DateTime? updatedAt;
  AttendanceStatusStatusX status;
  bool isConfirm;
  String? roleId;
  bool isAddCalendar;
  List<PermissionX> permissions;
  UserX? user;
  RoleX? role;
  MiniMeetingX? meeting;

  AttendanceX({
    required this.id,
    required this.meetingId,
    required this.userId,
    this.userRoleName,
    required this.invitationSent,
    this.comments,
    this.attendedAt,
    this.signature,
    required this.isOpen,
    required this.isVote,
    required this.isVoteDelegate,
    this.createdAt,
    this.updatedAt,
    required this.status,
    required this.isConfirm,
    this.roleId,
    required this.isAddCalendar,
    required this.permissions,
    this.user,
    this.meeting,
    this.role,
  });

  factory AttendanceX.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> permissionsJsonList = List<Map<String, dynamic>>.from((json[NameX.permissions] is! List ? [] : json[NameX.permissions]) as List);

      return ModelUtilX.checkFromJson(
        json,
            (json) => AttendanceX(
          id: json[NameX.id].toStrX,
          meetingId: json[NameX.meetingId].toStrX,
          userId: json[NameX.userId].toStrX,
          userRoleName: json[NameX.userRoleName].toStrNullableX,
          invitationSent: json[NameX.invitationSent].toBoolX,
          comments: json[NameX.comments].toStrNullableX,
          attendedAt: json[NameX.attendedAt].toDateTimeNullableX,
          signature: json[NameX.signature].toStrNullableX,
          isOpen: json[NameX.isOpen].toBoolX,
          isVote: json[NameX.isVote].toBoolX,
          isVoteDelegate: json[NameX.isVoteDelegate].toBoolX,
          createdAt: json[NameX.createdAt].toDateTimeNullableX,
          updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
          status: AttendanceStatusStatusX.values.firstWhere((x) => x.status==json[NameX.statusId].toIntDefaultX(2),),
          isConfirm: json[NameX.isConfirm].toBoolX,
          roleId: json[NameX.roleId].toStrX,
          isAddCalendar: json[NameX.isAddCalendar].toBoolDefaultX(false),
          permissions: ModelUtilX.generateItems(permissionsJsonList, PermissionX.fromJson),
          user: json[NameX.user].toFromJsonNullableX((x)=> UserX.fromJson(x,'')),
          meeting: json[NameX.meeting].toFromJsonNullableX(MiniMeetingX.fromJson),
          role: json[NameX.role].toFromJsonNullableX(RoleX.fromJson),
        ),
        requiredDataKeys: [NameX.id, NameX.meetingId, NameX.userId],
      );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.meetingId: meetingId,
      NameX.userId: userId,
      NameX.userRoleName: userRoleName,
      NameX.invitationSent: invitationSent,
      NameX.comments: comments,
      NameX.attendedAt: attendedAt?.toIso8601String(),
      NameX.signature: signature,
      NameX.isOpen: isOpen,
      NameX.isVote: isVote,
      NameX.isVoteDelegate: isVoteDelegate,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
      NameX.statusId: status.status,
      NameX.isConfirm: isConfirm,
      NameX.roleId: roleId,
      NameX.isAddCalendar: isAddCalendar,
      NameX.permissions: permissions.map((e) => e.toJson()).toList(),
      NameX.user: user?.toJson(),
      NameX.meeting: meeting?.toJson(),
      NameX.role: role?.toJson(),
    };
  }
}
