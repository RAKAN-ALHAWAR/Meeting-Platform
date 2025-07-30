import 'package:meeting/Data/data.dart';

class UpdatePasswordFormX {
  final String oldPassword;
  final String newPassword;

  UpdatePasswordFormX({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.oldPassword: oldPassword,
      NameX.newPassword: newPassword,
      NameX.passwordConfirmation: newPassword,
    };
  }
}
