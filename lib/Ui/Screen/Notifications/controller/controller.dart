import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../../../Data/data.dart';
import '../../../../Config/Translation/translation.dart';
import '../../../../Data/Model/notification/notification.dart';

class NotificationsController extends GetxController {
  //============================================================================
  // Variables

  RxList<NotificationX> notifications= <NotificationX>[].obs;

  //============================================================================
  // Functions

  Future getData()async{
    notifications.value = (await DatabaseX.getAllNotifications()).$2;
  }
  getTitle(){

  }

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting(TranslationX.getLanguageCode, null);
  }

}
