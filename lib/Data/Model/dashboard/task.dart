import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

import '../meeting/mini_meeting.dart';

class TaskX {
  TaskX({
    required this.id,
    required this.content,
    required this.meetingId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.meeting,
  });

  final int id;
  final String content;
  final int meetingId;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MiniMeetingX? meeting;

  factory TaskX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> meetingJson = Map<String, Object?>.from(
        json[NameX.meeting] ?? {});

    return ModelUtilX.checkFromJson(
      json,
          (json) =>
          TaskX(
            id: json[NameX.id].toIntX,
            content: json[NameX.content].toStrX,
            meetingId: json[NameX.meetingId].toIntX,
            userId: json[NameX.userId].toIntX,
            createdAt: json[NameX.createdAt].toDateTimeNullableX,
            updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
            meeting: meetingJson.toFromJsonNullableX(MiniMeetingX.fromJson),
          ),
      requiredDataKeys: [
        NameX.id,
        NameX.content,
        NameX.meetingId,
        NameX.userId,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.content: content,
      NameX.meetingId: meetingId,
      NameX.userId: userId,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
      NameX.meeting: meeting?.toJson(),
    };
  }
}