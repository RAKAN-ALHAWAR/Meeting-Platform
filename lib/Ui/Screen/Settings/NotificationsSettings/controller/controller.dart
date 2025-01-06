import 'package:get/get.dart';
import 'package:meeting/Data/Form/settings/notification_settings.dart';

import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class NotificationsSettingsController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  late RxBool appNotifications = app.user.value.appNotifications.obs;
  late RxBool emailNotifications = app.user.value.emailNotifications.obs;
  late RxBool whatsappNotifications = app.user.value.whatsappNotifications.obs;
  late RxBool smsNotifications = app.user.value.smsNotifications.obs;
  late RxBool googleCalenderNotifications =
      app.user.value.googleCalenderNotifications.obs;

  //============================================================================
  // Functions

  onChangeAppNotifications() async {
    try {
      appNotifications.value = !appNotifications.value;
      await DatabaseX.postNotificationSettings(
        form: NotificationSettingsFormX(
          whatsapp: whatsappNotifications.value,
          email: emailNotifications.value,
          sms: smsNotifications.value,
          app: appNotifications.value,
          googleCalender: googleCalenderNotifications.value,
        ),
      );
      app.user.value.appNotifications = appNotifications.value;
    } catch (e) {
      appNotifications.value = !appNotifications.value;
      ToastX.error(message: e);
    }
  }

  onChangeEmailNotifications() async {
    try {
      emailNotifications.value = !emailNotifications.value;
      await DatabaseX.postNotificationSettings(
        form: NotificationSettingsFormX(
          whatsapp: whatsappNotifications.value,
          email: emailNotifications.value,
          sms: smsNotifications.value,
          app: appNotifications.value,
          googleCalender: googleCalenderNotifications.value,
        ),
      );
      app.user.value.emailNotifications = emailNotifications.value;
    } catch (e) {
      emailNotifications.value = !emailNotifications.value;
      ToastX.error(message: e);
    }
  }
  onChangeWhatsappNotifications()async{
    try{
      whatsappNotifications.value=!whatsappNotifications.value;
      await DatabaseX.postNotificationSettings(
        form: NotificationSettingsFormX(
          whatsapp: whatsappNotifications.value,
          email: emailNotifications.value,
          sms: smsNotifications.value,
          app: appNotifications.value,
          googleCalender: googleCalenderNotifications.value,
        ),
      );
      app.user.value.whatsappNotifications=whatsappNotifications.value;
    }catch(e){
      whatsappNotifications.value=!whatsappNotifications.value;
      ToastX.error(message: e);
    }
  }
  onChangeSmsNotifications()async{
    try{
      smsNotifications.value=!smsNotifications.value;
      await DatabaseX.postNotificationSettings(
        form: NotificationSettingsFormX(
          whatsapp: whatsappNotifications.value,
          email: emailNotifications.value,
          sms: smsNotifications.value,
          app: appNotifications.value,
          googleCalender: googleCalenderNotifications.value,
        ),
      );
      app.user.value.smsNotifications=smsNotifications.value;
    }catch(e){
      smsNotifications.value=!smsNotifications.value;
      ToastX.error(message: e);
    }
  }
  onChangeGoogleCalenderNotifications()async{
    try{
      googleCalenderNotifications.value=!googleCalenderNotifications.value;
      await DatabaseX.postNotificationSettings(
        form: NotificationSettingsFormX(
          whatsapp: whatsappNotifications.value,
          email: emailNotifications.value,
          sms: smsNotifications.value,
          app: appNotifications.value,
          googleCalender: googleCalenderNotifications.value,
        ),
      );
      app.user.value.googleCalenderNotifications=googleCalenderNotifications.value;
    }catch(e){
      googleCalenderNotifications.value=!googleCalenderNotifications.value;
      ToastX.error(message: e);
    }
  }
}
