import 'package:get/get.dart';
import 'package:meeting/Ui/Screen/Delegate/AllDelegates/controller/controller.dart';

import '../../UI/Screen/Auth/Login/controller/controller.dart';
import '../../UI/Screen/Auth/Login/view/view.dart';
import '../../UI/Screen/Auth/OTP/controller/controller.dart';
import '../../UI/Screen/Auth/OTP/view/view.dart';
import '../../Ui/Screen/Auth/ForgotPassword/controller/controller.dart';
import '../../Ui/Screen/Auth/ForgotPassword/view/view.dart';
import '../../Ui/Screen/Auth/ForgotPasswordReset/controller/controller.dart';
import '../../Ui/Screen/Auth/ForgotPasswordReset/view/view.dart';
import '../../Ui/Screen/Home/controller/controller.dart';
import '../../Ui/Screen/Loading/controller/controller.dart';
import '../../Ui/Screen/Loading/view/view.dart';
import '../../Ui/Screen/Meeting/AllMeetings/controller/controller.dart';
import '../../Ui/Screen/Meeting/MeetingDetails/controller/controller.dart';
import '../../Ui/Screen/Meeting/MeetingDetails/view/view.dart';
import '../../Ui/Screen/Meeting/MeetingMinutes/controller/controller.dart';
import '../../Ui/Screen/Meeting/MeetingMinutes/view/view.dart';
import '../../Ui/Screen/Notifications/controller/controller.dart';
import '../../Ui/Screen/Notifications/view/view.dart';
import '../../Ui/Screen/FileReader/controller/controller.dart';
import '../../Ui/Screen/FileReader/view/view.dart';
import '../../Ui/Screen/Profile/ChangePassword/controller/controller.dart';
import '../../Ui/Screen/Profile/ChangePassword/view/view.dart';
import '../../Ui/Screen/Profile/EditProfile/controller/controller.dart';
import '../../Ui/Screen/Profile/EditProfile/view/view.dart';
import '../../Ui/Screen/Profile/ProfileDetails/controller/controller.dart';
import '../../Ui/Screen/Root/controller/controller.dart';
import '../../Ui/Screen/Root/view/view.dart';
import '../../Ui/Screen/Settings/AutomaticAttendances/controller/controller.dart';
import '../../Ui/Screen/Settings/AutomaticAttendances/view/view.dart';
import '../../Ui/Screen/Settings/NotificationsSettings/controller/controller.dart';
import '../../Ui/Screen/Settings/NotificationsSettings/view/view.dart';
import '../../Ui/Screen/Signatures/controller/controller.dart';
import '../../Ui/Screen/Signatures/view/view.dart';
import '../../Ui/Screen/Suggestion/AddSuggestion/controller/controller.dart';
import '../../Ui/Screen/Suggestion/AddSuggestion/view/view.dart';
import '../../Ui/Screen/Suggestion/MySuggestions/controller/controller.dart';
import '../../Ui/Screen/Suggestion/MySuggestions/view/view.dart';
import '../../Ui/Screen/Suggestion/SuggestionDetails/controller/controller.dart';
import '../../Ui/Screen/Suggestion/SuggestionDetails/view/view.dart';
import '../../Ui/Screen/WebView/controller/controller.dart';
import '../../Ui/Screen/WebView/view/view.dart';
import '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Link pages to their controller via the page name
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class RouteListX {
  /// List Routes
  static final List<GetPage<dynamic>> routes = [
    /// Root
    GetPage(
      name: RouteNameX.root,
      page: () => const RootView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => RootController(),
            fenix: true,
          );
          Get.lazyPut(
            () => HomeController(),
          );
          Get.lazyPut(
            () => AllMeetingsController(),
          );
          Get.lazyPut(
            () => AllDelegatesController(),
          );
          Get.lazyPut(
            () => ProfileDetailsController(),
          );
        },
      ),
    ),
    //========================================================
    /// Loading
    GetPage(
        name: RouteNameX.loading,
        page: () => const LoadingView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoadingController());
        })),
    //========================================================
    ///Auth
    GetPage(
        name: RouteNameX.login,
        page: () => const LoginView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
        })),
    GetPage(
        name: RouteNameX.forgotPassword,
        page: () => const ForgotPasswordView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ForgotPasswordController());
        })),
    GetPage(
        name: RouteNameX.forgotPasswordReset,
        page: () => const ForgotPasswordResetView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ForgotPasswordResetController());
        })),
    GetPage(
        name: RouteNameX.otp,
        page: () => const OTPView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => OTPController());
        })),
    //========================================================
    /// Profile
    GetPage(
        name: RouteNameX.editProfile,
        page: () => const EditProfileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EditProfileController());
        })),
    GetPage(
        name: RouteNameX.changePassword,
        page: () => const ChangePasswordView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ChangePasswordController());
        })),
    //========================================================
    /// Notifications
    GetPage(
        name: RouteNameX.notifications,
        page: () => const NotificationsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(
            () => NotificationsController(),
          );
        })),
    GetPage(
        name: RouteNameX.notificationsSettings,
        page: () => const NotificationsSettingsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => NotificationsSettingsController());
        })),
    //========================================================
    /// Automatic Attendances
    GetPage(
        name: RouteNameX.automaticAttendances,
        page: () => const AutomaticAttendancesView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AutomaticAttendancesController());
        })),
    //========================================================
    /// Signatures
    GetPage(
        name: RouteNameX.signatures,
        page: () => const SignaturesView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SignaturesController());
        })),
    //========================================================
    /// Suggestion
    GetPage(
        name: RouteNameX.addSuggestion,
        page: () => const AddSuggestionView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AddSuggestionController());
        })),
    GetPage(
        name: RouteNameX.mySuggestions,
        page: () => const MySuggestionsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MySuggestionsController());
        })),
    GetPage(
        name: RouteNameX.suggestionDetails,
        page: () => const SuggestionDetailsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SuggestionDetailsController());
        })),
    //========================================================
    /// Meeting
    GetPage(
        name: RouteNameX.meetingDetails,
        page: () => const MeetingDetailsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MeetingDetailsController());
        })),
    GetPage(
        name: RouteNameX.meetingMinutes,
        page: () => const MeetingMinutesView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MeetingMinutesController());
        })),
    //========================================================
    /// Other
    GetPage(
        name: RouteNameX.myWebView,
        page: () => const MyWebViewView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MyWebViewController());
        })),
    GetPage(
        name: RouteNameX.fileReader,
        page: () => const FileReaderView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => FileReaderController());
        })),
    //========================================================
    /// Template
    // GetPage(
    //    name: RouteNameX.,
    //    page: () => const View(),
    //    binding: BindingsBuilder(() {
    //      Get.lazyPut(
    //              () => Controller());
    //    })),
    //
  ];
}
