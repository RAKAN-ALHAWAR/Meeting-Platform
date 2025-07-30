import 'package:meeting/Data/data.dart';

class UpdateProfileFormX {
  final String name;
  final String idNumber;
  final String? phone;

  UpdateProfileFormX({
    required this.name,
    required this.idNumber,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.name: name.trim(),
      NameX.idNumber: idNumber.trim(),
      if(phone!=null)
      NameX.phone: phone?.trim(),
    };
  }
}
