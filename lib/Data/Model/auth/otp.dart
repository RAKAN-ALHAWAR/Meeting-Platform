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

}
