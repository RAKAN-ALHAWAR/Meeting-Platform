import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meeting/Data/Enum/notification_type_status.dart';
import '../../../../../Data/data.dart';
import '../../../../Config/Translation/translation.dart';
import '../../../../Data/Model/notification/notification.dart';
import '../../../../UI/Widget/widget.dart';
import '../../../ScreenSheet/Delegate/AcceptDelegate/view/acceptDelegateSheet.dart';

class NotificationsController extends GetxController {
  //============================================================================
  // Variables

  RxList<NotificationX> notifications= <NotificationX>[].obs;

  //============================================================================
  // Functions

  Future getData()async{
    notifications.value = (await DatabaseX.getAllNotifications()).$2;
    // for(int i=0;i<notifications.length;i++){
    //   if(notifications[i].data.type==NotificationTypeStatusX.confirmAttendanceMeeting){
    //     await DatabaseX.dele
    //   }
    // }
  }

  onAcceptDelegate(NotificationX notification)async{
    // try {
    //   final result = await acceptDelegateSheetX(id: delegate.id);
    //   if (result == true) {
    //     scrollRefreshLoadMoreKey.currentState?.resetData();
    //   }
    // } catch (e) {
    //   ToastX.error(message: e);
    // }
  }
  onRejectDelegate(NotificationX notification)async{
    // try {
    //   final result = await acceptDelegateSheetX(id: delegate.id);
    //   if (result == true) {
    //     scrollRefreshLoadMoreKey.currentState?.resetData();
    //   }
    // } catch (e) {
    //   ToastX.error(message: e);
    // }
  }

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting(TranslationX.getLanguageCode, null);
  }

}
