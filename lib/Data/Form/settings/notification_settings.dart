import 'package:meeting/Data/data.dart';

class NotificationSettingsFormX {
  final bool whatsapp;
  final bool email;
  final bool sms;
  final bool app;
  final bool googleCalender;

  NotificationSettingsFormX({
    required this.whatsapp,
    required this.email,
    required this.sms,
    required this.app,
    required this.googleCalender,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.whatsappNotifications: whatsapp,
      NameX.emailNotifications: email,
      NameX.smsNotifications: sms,
      NameX.appNotifications: app,
      NameX.googleCalenderNotifications: googleCalender,
    };
  }
}
