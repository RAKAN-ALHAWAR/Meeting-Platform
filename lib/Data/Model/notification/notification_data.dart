import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

import '../../Enum/notification_type_status.dart';

class NotificationDataX {
  NotificationDataX({
    required this.meetingId,
    required this.type,
    required this.meetingTitle,
    required this.msg,
    required this.link,
  });

  final int meetingId;
  final NotificationTypeStatusX type;
  final String meetingTitle;
  final String msg;
  final String link;

  factory NotificationDataX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => NotificationDataX(
        meetingId: json[NameX.meetingId].toIntX,
        type: NotificationTypeStatusX.values.firstWhere((x) => x.name==json[NameX.notificationType].toStrDefaultX('').toLowerCase(),orElse: () => NotificationTypeStatusX.other,),
        meetingTitle: json[NameX.meetingTitle].toStrX,
        msg: json[NameX.msg].toStrX,
        link: json[NameX.link].toStrX,
      ),
      requiredDataKeys: [
        NameX.meetingId,
        NameX.meetingTitle,
        NameX.msg,
        NameX.link,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.meetingId: meetingId,
      NameX.notificationType: type.name,
      NameX.meetingTitle: meetingTitle,
      NameX.msg: msg,
      NameX.link: link,
    };
  }
}