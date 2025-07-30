import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class RoleX {
  RoleX({
    required this.id,
    required this.name,
    this.guardName,
    this.createdAt,
    this.isDefault,
  });

  final String id;
  final String name;
  final String? guardName;
  final DateTime? createdAt;
  final bool? isDefault;

  factory RoleX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => RoleX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        guardName: json[NameX.guardName].toStrDefaultX(''),
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        isDefault: json[NameX.isDefault].toBoolNullableX,
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
      NameX.guardName: guardName,
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.isDefault: isDefault,
    };
  }
}