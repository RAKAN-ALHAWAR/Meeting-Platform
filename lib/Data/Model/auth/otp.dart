part of '../../data.dart';

class OtpX {
  OtpX({
    this.email,
    this.phone,
    this.countryCode,
    required this.isLogin,
    required this.isPhone,
    this.isEdit = false,
  });

  OtpX.empty();

  late String? email;
  late int? phone;
  late int? countryCode;
  late bool isLogin;
  late bool isPhone;
  late bool isEdit;

  factory OtpX.fromJson(Map<String, dynamic> json) {
    return OtpX(
      email: json[NameX.email],
      phone: (json[NameX.phone]??0).toIntX,
      countryCode: json[NameX.countryCode],
      isLogin: json[NameX.isLogin] ?? false,
      isPhone: json[NameX.isPhone] ?? false,
      isEdit: json[NameX.isEdit] ?? false,
    );
  }
}
