library data;

import 'dart:async';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/Data/Form/attendance/confirm_attendance.dart';
import 'package:meeting/Data/Form/profile/update_profile.dart';
import 'package:meeting/Data/Model/Basic/data_source_param.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meeting/Data/Model/meeting/sub/question.dart';
import 'package:meeting/Data/Model/signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import '../Config/Translation/translation.dart';
import '../Config/config.dart';

import '../Core/Error/error.dart';
import '../Core/Helper/model/model.dart';
import '../Core/Service/firebaseRemoteConfigService.dart';
import 'Database/Remote/remote_data.dart';
import 'Database/config/database_end_point.dart';
import 'Enum/meeting_status_status.dart';
import 'Form/Auth/forget_password_otp_check_code.dart';
import 'Form/auth/forget_password_reset.dart';
import 'Form/auth/phone_otp_check_code.dart';
import 'Form/auth/update_password.dart';
import 'Form/rate/add_rate.dart';
import 'Form/settings/notification_settings.dart';
import 'Form/suggestion/add_meeting_suggestion.dart';
import 'Form/suggestion/add_suggestion.dart';
import 'Form/vote/vote.dart';
import 'Form/vote/vote_delegate.dart';
import 'Model/User/user.dart';
import 'Model/attachment/attachment.dart';
import 'Model/attendance/attendance.dart';
import 'Model/dashboard/dashboard.dart';
import 'Model/dashboard/statistics.dart';
import 'Model/dashboard/task.dart';
import 'Model/delegate/delegate.dart';
import 'Model/meeting/meeting.dart';
import 'Model/meeting/sub/agenda.dart';
import 'Model/notification/notification.dart';
import 'Model/suggestion/suggestion.dart';
import 'Model/user/mini_user.dart';

part 'Constant/constant.dart';
part 'Enum/enum.dart';
part 'Constant/name.dart';
part 'Database/database.dart';
part 'Local/config/local_default_data.dart';
part 'Local/config/local_key.dart';
part 'Local/local_data.dart';
part 'Local/storage/hive.dart';
part 'Model/Basic/scroll_refresh_load_more_parameters.dart';



// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Control all types of data within the application, including static data,
/// managing data stored on the device, database connections, data models, etc.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class DataX {
  static init() async {
    /// Formatting and retrieving data stored on the device
    await LocalDataX.init();

    /// Configure database connections
    await DatabaseX.init();
  }
}
