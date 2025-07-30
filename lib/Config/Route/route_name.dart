part of '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// This class is used to navigate between pages using the page name
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class RouteNameX {
  /// Root
  static const String root = '/';

  /// Loading
  static const String loading = '/loading';

  /// Auth
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String forgotPasswordReset = '/forgotPasswordReset';
  static const String otp = '/otp';

  /// Profile
  static const String editProfile = '/editProfile';
  static const String changePassword = '/changePassword';

  /// Settings
  static const String automaticAttendances = '/automaticAttendances';
  static const String notificationsSettings = '/notificationsSettings';

  /// Signatures
  static const String signatures = '/signatures';

  /// Suggestions
  static const String addSuggestion = '/addSuggestion';
  static const String mySuggestions = '/mySuggestions';
  static const String suggestionDetails = '/suggestionDetails';

  /// Notifications
  static const String notifications = '/notifications';

  /// Meeting
  static const String meetingDetails = '/meetingDetails';
  static const String meetingMinutes = '/meetingMinutes';


  /// Other
  static const String myWebView = '/webView';
  static const String fileReader = '/fileReader';

}
