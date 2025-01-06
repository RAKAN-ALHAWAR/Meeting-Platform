import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meeting/Config/Translation/translation.dart';
import 'package:meeting/Data/Model/dashboard/dashboard.dart';
import 'package:meeting/Data/Model/dashboard/task.dart';
import 'package:meeting/Data/Model/meeting/meeting.dart';
import 'package:meeting/Data/data.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../../../Data/Model/notification/notification.dart';

class HomeController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  late DashboardX dashboard;
  List<DateTime> datesOfCalendar = [];
  List<NotificationX> notifications= [];
  RxBool isHasNewNotification = false.obs;

  //============================================================================
  // Functions

  Future getData()async{
    await initializeDateFormatting(TranslationX.getLanguageCode, null);
    dashboard = await DatabaseX.getDashboard();
    notifications = (await DatabaseX.getAllNotifications()).$2;
    isHasNewNotification.value= notifications.firstWhereOrNull((x) => x.readAt==null)!=null;
  }

  onNotifications()=>Get.toNamed(RouteNameX.notifications);
  onUpcomingMeetings()=>Get.toNamed(RouteNameX.notifications);
  onMeetingDetails(MeetingX meeting)=>Get.toNamed(RouteNameX.meetingDetails,arguments: meeting.id);
  onMeetingDetailsByTask(TaskX task)=>Get.toNamed(RouteNameX.meetingDetails,arguments: task.meetingId);
  onDateSelectedCalendar(DateTime date){

  }
}