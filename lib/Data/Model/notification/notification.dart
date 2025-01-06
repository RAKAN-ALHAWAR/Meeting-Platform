import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

import 'notification_data.dart';

class NotificationX {
  NotificationX({
    required this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    required this.data,
    this.readAt,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final NotificationDataX data;
  final DateTime? readAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  factory NotificationX.fromJson(Map<String, dynamic> json) {
    /// TODO: تعديل الموديل من أجل اكتشاف نوع الصحيح للاشعار ونقل المستخدم للمكان الصحيح
    Map<String, Object?> notificationDataXJson = Map<String, Object?>.from(json[NameX.data] ?? {});
    return ModelUtilX.checkFromJson(
      json,
          (json) => NotificationX(
        id: json[NameX.id].toStrX,
        type: json[NameX.type].toStrNullableX,
        notifiableType: json[NameX.notifiableType].toStrNullableX,
        notifiableId: json[NameX.notifiableId].toIntNullableX,
        data: NotificationDataX.fromJson(notificationDataXJson),
        readAt: json[NameX.readAt]?.toDateTimeNullableX,
        createdAt: json[NameX.createdAt].toDateTimeX,
        updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.data,
        NameX.createdAt,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.type: type,
      NameX.notifiableType: notifiableType,
      NameX.notifiableId: notifiableId,
      NameX.data: data.toJson(),
      NameX.readAt: readAt?.toIso8601String(),
      NameX.createdAt: createdAt.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}
