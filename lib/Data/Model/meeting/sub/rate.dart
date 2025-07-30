import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class RateX {
  final String id;
  final int rate;
  final String comment;
  final String meetingId;
  final String userId;
  final DateTime? createdAt;

  RateX({
    required this.id,
    required this.rate,
    required this.comment,
    required this.meetingId,
    required this.userId,
    this.createdAt,
  });

  factory RateX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => RateX(
        id: json[NameX.id].toStrX,
        rate: json[NameX.rate].toIntX,
        comment: json[NameX.comment].toStrX,
        meetingId: json[NameX.meetingId].toStrX,
        userId: json[NameX.userId].toStrX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.rate,
        NameX.comment,
        NameX.meetingId,
        NameX.userId,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.rate: rate,
      NameX.comment: comment,
      NameX.meetingId: meetingId,
      NameX.userId: userId,
      NameX.createdAt: createdAt?.toIso8601String(),
    };
  }
}