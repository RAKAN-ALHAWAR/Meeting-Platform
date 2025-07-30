import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class MiniUserX {
  final String id;
  final String name;

  MiniUserX({
    required this.id,
    required this.name,
  });

  factory MiniUserX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => MiniUserX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
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
    };
  }
}
