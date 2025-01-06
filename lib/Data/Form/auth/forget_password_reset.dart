import 'package:meeting/Data/data.dart';

class ForgetPasswordResetFormX {
  final String token;
  final String newPassword;

  ForgetPasswordResetFormX({
    required this.token,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.newPassword: newPassword,
      NameX.newPasswordConfirmation: newPassword,
    };
  }
}
