import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class AgendaX {
  final String id;
  final String meetingId;
  final String duration;
  final String content;
  final String? recommendContent;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AgendaX({
    required this.id,
    required this.meetingId,
    required this.duration,
    required this.content,
    required this.recommendContent,
    this.createdAt,
    this.updatedAt,
  });

  factory AgendaX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => AgendaX(
        id: json[NameX.id].toStrX,
        meetingId: json[NameX.meetingId].toStrX,
        duration: json[NameX.duration].toStrX,
        content: json[NameX.content].toStrX,
        recommendContent: json[NameX.recommendContent].toStrNullableX,
        createdAt: json[NameX.createdAt]?.toDateTimeX,
        updatedAt: json[NameX.updatedAt]?.toDateTimeX,
      ),
      requiredDataKeys: [NameX.id, NameX.meetingId, NameX.duration, NameX.content, NameX.recommendContent],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.meetingId: meetingId,
      NameX.duration: duration,
      NameX.content: content,
      NameX.recommendContent: recommendContent,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}