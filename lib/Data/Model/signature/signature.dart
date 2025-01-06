import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class SignatureX {
  final String id;
  final String imageUrl;

  SignatureX({
    required this.id,
    required this.imageUrl,
  });

  factory SignatureX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => SignatureX(
        id: json[NameX.id].toStrX,
        imageUrl: json[NameX.imageUrl].toStrX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.imageUrl,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.imageUrl: imageUrl,
    };
  }
}
