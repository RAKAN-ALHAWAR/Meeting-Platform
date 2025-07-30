import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class PermissionX {
  final String id;
  final String name;
  final String? attendanceId;

  PermissionX({
    required this.id,
    required this.name,
    this.attendanceId,
  });

  factory PermissionX.fromJson(Map<String, dynamic> json) {
    Map<String,Object?> pivotJson = Map<String,Object?>.from(json[NameX.pivot]??{});
    return ModelUtilX.checkFromJson(
      json,
      (json) => PermissionX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        attendanceId: pivotJson[NameX.attendanceId].toStrNullableX,
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
      NameX.name:name,
      NameX.pivot:{
        NameX.attendanceId:attendanceId,
      }
    };
  }
}
