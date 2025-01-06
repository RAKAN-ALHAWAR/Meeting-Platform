import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class StatisticsX {
  final int meetingCount;
  final int newMeetingCount;

  StatisticsX({
    required this.meetingCount,
    required this.newMeetingCount,
  });

  factory StatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => StatisticsX(
        meetingCount: json[NameX.meetingCount].toIntDefaultX(0),
        newMeetingCount: json[NameX.newMeetingCount].toIntDefaultX(0),
      ),
      requiredDataKeys: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.meetingCount: meetingCount,
      NameX.newMeetingCount: newMeetingCount,
    };
  }
}
