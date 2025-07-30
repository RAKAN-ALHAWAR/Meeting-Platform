import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class VisitorX {
  final String id;
  final String email;
  final String meetingId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VisitorX({
    required this.id,
    required this.email,
    required this.meetingId,
    this.createdAt,
    this.updatedAt,
  });

  factory VisitorX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => VisitorX(
        id: json[NameX.id].toStrX,
        email: json[NameX.email].toStrX,
        meetingId: json[NameX.meetingId].toStrX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.email,
        NameX.meetingId,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.email: email,
      NameX.meetingId: meetingId,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}
