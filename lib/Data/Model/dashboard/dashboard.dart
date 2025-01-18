import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/Model/dashboard/statistics.dart';
import 'package:meeting/Data/Model/dashboard/task.dart';
import 'package:meeting/Data/data.dart';

import '../meeting/meeting.dart';

class DashboardX {
  final StatisticsX statistics;
  final List<TaskX> tasks;
  final List<MeetingX> newMeetings;

  DashboardX({
    required this.statistics,
    required this.tasks,
    required this.newMeetings,
  });

  factory DashboardX.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> taskJson = List<Map<String, dynamic>>.from((json[NameX.task] is List ? json[NameX.task] : [])
        .map((item) => (item as Map).map(
          (key, value) => MapEntry(key.toString(), value),
    )).toList());

    List<Map<String, dynamic>> meetingsJson = List<Map<String, dynamic>>.from((json[NameX.newMeeting]?[NameX.data] is List ? json[NameX.newMeeting][NameX.data] : [])
        .map((item) => (item as Map).map(
          (key, value) => MapEntry(key.toString(), value),
    )).toList());

    return ModelUtilX.checkFromJson(
      json,
      (json) => DashboardX(
        statistics: StatisticsX.fromJson(json),
        tasks: ModelUtilX.generateItems(taskJson, TaskX.fromJson),
        newMeetings: ModelUtilX.generateItems(meetingsJson, MeetingX.fromJson),
      ),
      requiredDataKeys: [
        NameX.newMeeting,
        NameX.task,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ...statistics.toJson(),
      NameX.newMeeting:newMeetings.map((e) => e.toJson).toList(),
      NameX.task:tasks.map((e) => e.toJson).toList(),
    };
  }
}
