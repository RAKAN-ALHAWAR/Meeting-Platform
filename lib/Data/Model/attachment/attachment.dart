import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class AttachmentX {
  final int id;
  final String link;
  final String name;
  final String type;
  final String path;
  final DateTime? createdAt;

  AttachmentX({
    required this.id,
    required this.link,
    required this.name,
    required this.type,
    required this.path,
    this.createdAt,
  });

  factory AttachmentX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => AttachmentX(
        id: json[NameX.id].toIntX,
        link: json[NameX.link].toStrX,
        name: json[NameX.thumbLink].toStrX,
        type: json[NameX.type].toStrDefaultX(''),
        path: json[NameX.path].toStrX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.link,
        NameX.thumbLink,
        NameX.path,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.link: link,
      NameX.name: name,
      NameX.type: type,
      NameX.path: path,
      NameX.createdAt: createdAt?.toIso8601String(),
    };
  }
}
