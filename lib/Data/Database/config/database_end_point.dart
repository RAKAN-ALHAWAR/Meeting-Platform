/// Contains links to database connection points
class DBEndPointX {
  //============================================================================
  // Main API links

  static late final String mainAPI;
  
  //============================================================================
  // Auth

  // static final String postSignUp = '${mainAPI}auth/signup';
  static final String postLogin = '${mainAPI}auth/login';
  static final String postLoginByPhone = '${mainAPI}auth/mobile/login';
  static final String postPhoneOtp = '${mainAPI}auth/mobile/verification';
  static final String postLoginByGoogle = '${mainAPI}auth/google/login';
  static final String postForgotPassword = '${mainAPI}auth/password/email';
  static final String postForgotPasswordOtpCheckCode = '${mainAPI}auth/password/check-code';
  static final String postForgotPasswordReset = '${mainAPI}auth/password/update-password';
  static final String getLogout = '${mainAPI}auth/logout';
  // static final String postForgotPasswordResetOtpWithPassword = '${mainAPI}auth/password/reset';
  // static final String getLogoutOtherBrowser = '${mainAPI}auth/logout-other-browser';

  //============================================================================
  // Profile

  static final String getProfile = '${mainAPI}user';
  static final String postUpdateProfile = '${mainAPI}auth/update/my-profile';
  static final String postUpdatePassword = '${mainAPI}auth/update/my-password';
  static final String postUpdateImage = '${mainAPI}auth/update/my-picture';
  static final String deleteProfileImage = '${mainAPI}auth/delete/my-picture';

  //============================================================================
  // Languages

  // static final String getLanguages = '${mainAPI}lang';

  //============================================================================
  // Notifications

  static final String getNotifications = '${mainAPI}my-notifications';
  static final String getMarkAsReadNotifications = '${mainAPI}mark-as-read/{id}';
  static final String postNotificationsSettings = '${mainAPI}users/allow/all-notifications';

  //============================================================================
  // Users

  static final String getUserByRoleAndMeetingName ='${mainAPI}user/search/delegate/{role_id}/{meeting_name}';

  //============================================================================
  // Automatic Attendances

  static final String postAutomaticAttendances ='${mainAPI}users/automatic/attendances';

  // ===========================================================================
  // Attachment

  static final String postUploadAttachment = '${mainAPI}attachment';

  // ===========================================================================
  // Suggestions

  static final String postAddSuggestions = '${mainAPI}suggestions';
  static final String postAddMeetingSuggestion = '${mainAPI}admin/meetings/{id}/meeting_suggestion';
  static final String getAllSuggestions = '${mainAPI}suggestions';
  static final String getSuggestionDetails = '${mainAPI}suggestions/{id}';
  static final String deleteSuggestion = '${mainAPI}suggestions/{id}';

  //============================================================================
  // Meeting

  static final String getMeetingDetails = '${mainAPI}meetings/{id}';
  static final String getAllMeetings = '${mainAPI}admin/meetings';
  static final String getAllRecurringMeetings = '${mainAPI}admin/meetings/recurring';
  static final String getAllMyMeetings = '${mainAPI}admin/meetings/my/meeting';
  static final String getAllNewMeetings = '${mainAPI}dashboard/employee';
  static final String postAddSignatureMeetingMinutes = '${mainAPI}admin/attendance/signatures/{id}/add';
  static final String putChangeStatusCheckTask = '${mainAPI}meetings/task/{id}';

  // ============================================================================
  // Attendances

  static final String getAttendancesByMeetingId = '${mainAPI}admin/attendance/{id}/meeting';
  static final String postConfirmAttendance = '${mainAPI}attendances/confirm/{id}';

  //============================================================================
  // Users

  static final String getAttendanceUsersOfMeeting = '${mainAPI}admin/meetings/{id}/attendance/members';
  static final String getDelegateUsersOfMeeting = '${mainAPI}user/search/delegate/{id}';

  //============================================================================
  // Rate

  static final String postMeetingRate = '${mainAPI}admin/meetings/{id}/rate';

  // ===========================================================================
  // Delegate

  static final String getAllDelegates = '${mainAPI}delegates';
  static final String getAllMyDelegates = '${mainAPI}delegates/my';
  static final String getDelegateDetails = '${mainAPI}delegates/{id}';
  static final String postConfirmDelegate = '${mainAPI}delegates/confirm/{id}';

  // ===========================================================================
  // Signatures

  static final String getMySignature = '${mainAPI}my/signatures';
  static final String postAddSignature = '${mainAPI}my/signatures';
  static final String deleteMySignature = '${mainAPI}my/signatures';

  //============================================================================
  // Question

  static final String getAllQuestionsByMeeting = '${mainAPI}admin/meetings/{id}/question';

  //============================================================================
  // Agenda

  static final String getAgendaByMeeting = '${mainAPI}admin/meetings/{id}/agenda';

  // ============================================================================
  // Vote

  static final String postMeetingVoteQuestions = '${mainAPI}meetings/meeting-vote/{id}';
  static final String postMeetingDelegateVoteQuestions = '${mainAPI}meetings/meeting-delegate-vote/{id}';

  //============================================================================
  // Statistics

  static final String getStatistics = '${mainAPI}dashboard/employee';

  //============================================================================
  // Task

  static final String getAllTasks = '${mainAPI}dashboard/employee';

  //============================================================================
  // Dashboard

  static final String getDashboard = '${mainAPI}dashboard/employee';

  // ===========================================================================
  // Calendars

  /// TODO: Add all calender end point to Database file
  static final String getCalendarAuthUrl = '${mainAPI}calendars/create/oauth';
  static final String getCalendarCreateEvent = '${mainAPI}calendars/create/event';
  static final String getCalendarEvents = '${mainAPI}calendars/get/event';
  static final String getCheckCalendar = '${mainAPI}calendars';

}
