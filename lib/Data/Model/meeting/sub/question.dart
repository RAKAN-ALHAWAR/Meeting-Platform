import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

import '../../../Enum/selection_type_status.dart';
import 'answer.dart';

class QuestionX {
  final int id;
  final String text;
  final String meetingId;
  final SelectionTypeStatusX selectionType;
  final bool status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AnswerX> answers;

  QuestionX({
    required this.id,
    required this.text,
    required this.meetingId,
    required this.selectionType,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.answers,
  });

  factory QuestionX.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> answersJsonList = List<Map<String, dynamic>>.from((json[NameX.answers] is! List ? [] : json[NameX.answers]) as List);
    return ModelUtilX.checkFromJson(
      json,
          (json) => QuestionX(
        id: json[NameX.id].toIntX,
        text: json[NameX.text].toStrX,
        meetingId: json[NameX.meetingId].toStrX,
        selectionType: SelectionTypeStatusX.values.firstWhere((x) => x.name==json[NameX.selection].toStrX.toLowerCase()),
        status: json[NameX.status].toBoolX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
        answers: ModelUtilX.generateItems(answersJsonList, AnswerX.fromJson),
      ),
      requiredDataKeys: [NameX.id, NameX.text, NameX.meetingId, NameX.selection],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.text: text,
      NameX.meetingId: meetingId,
      NameX.selection: selectionType.name,
      NameX.status: status,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
      NameX.answers: answers.map((e) => e.toJson()).toList(),
    };
  }
}