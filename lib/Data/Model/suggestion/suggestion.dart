import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

import '../attachment/attachment.dart';

class SuggestionX {
  final String id;
  final String? title;
  final String? userId;
  final String message;
  final String? replyMessage;
  final DateTime? readAt;
  final DateTime createdAt;
  final List<AttachmentX> attachments;

  SuggestionX({
    required this.id,
    this.title,
    this.userId,
    required this.message,
    this.replyMessage,
    this.readAt,
    required this.createdAt,
    this.attachments = const[],
  });

  factory SuggestionX.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> attachmentsListJson = List<Map<String, dynamic>>.from((json[NameX.attachments] is! List ? [] :json[NameX.attachments]) as List);

    return ModelUtilX.checkFromJson(
      json,
      (json) => SuggestionX(
        id: json[NameX.id].toStrX,
        title: json[NameX.title].toStrNullableX,
        userId: json[NameX.userId].toStrNullableX,
        message: json[NameX.message].toStrNullableX ?? json[NameX.description].toStrX,
        replyMessage: json[NameX.replyMessage].toStrNullableX,
        readAt: json[NameX.readAt].toDateTimeNullableX,
        createdAt: json[NameX.createdAt].toDateTimeX,
        attachments: ModelUtilX.generateItems(attachmentsListJson, AttachmentX.fromJson)
      ),
      requiredDataKeys: [
        NameX.id,
        // NameX.title,
        // NameX.message,
        NameX.createdAt
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.title: title,
      NameX.message: message,
      NameX.replyMessage: replyMessage,
      NameX.readAt: readAt?.toIso8601String(),
      NameX.createdAt: createdAt.toIso8601String(),
    };
  }
}
