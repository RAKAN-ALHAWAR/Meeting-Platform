import 'package:meeting/Data/data.dart';

class ForgetPasswordOtpCheckCodeFormX {
  final String email;
  final String otpCode;

  ForgetPasswordOtpCheckCodeFormX({
    required this.email,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.email: email,
      NameX.code: otpCode,
    };
  }
}
