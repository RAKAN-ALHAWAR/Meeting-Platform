import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class MeetingTypeX {
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MeetingTypeX({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MeetingTypeX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => MeetingTypeX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        description: json[NameX.description]?.toStrX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.name,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.description: description,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}
