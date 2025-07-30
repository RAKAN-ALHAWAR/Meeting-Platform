import 'package:meeting/Data/data.dart';

class PhoneOtpCheckCodeFormX {
  final int phone;
  final int countryCode;
  final String otpCode;

  PhoneOtpCheckCodeFormX({
    required this.phone,
    required this.countryCode,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.phone: phone.toString(),
      NameX.countryCode: countryCode.toString(),
      NameX.code: otpCode,
    };
  }
}
