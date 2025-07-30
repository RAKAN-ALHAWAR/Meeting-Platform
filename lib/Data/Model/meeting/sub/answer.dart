import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class AnswerX {
  final int id;
  final String text;
  final int questionId;
  final bool status;
  final int votesCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AnswerX({
    required this.id,
    required this.text,
    required this.questionId,
    required this.status,
    this.votesCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory AnswerX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => AnswerX(
        id: json[NameX.id].toIntX,
        text: json[NameX.text].toStrX,
        questionId: json[NameX.questionId].toIntX,
        status: json[NameX.status].toBoolX,
        votesCount: json[NameX.votesCount].toIntDefaultX(0),
        createdAt: json[NameX.createdAt]?.toDateTimeX,
        updatedAt: json[NameX.updatedAt]?.toDateTimeX,
      ),
      requiredDataKeys: [NameX.id, NameX.text, NameX.questionId, NameX.status],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.text: text,
      NameX.questionId: questionId,
      NameX.status: status,
      NameX.votesCount: votesCount,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}