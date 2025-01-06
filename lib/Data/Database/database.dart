part of '../data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Manage all database connections
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class DatabaseX {
  static init() async {
    try {
      /// Here codes are added to configure anything within this section when the application starts
      DBEndPointX.mainAPI = FirebaseRemoteConfigServiceX.getString(
        'base_url',
        'https://meeting-testing.edialoguecenter.com/api/',
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  //============================================================================
  // Auth

  static Future<UserX> login({
    required String email,
    required String password,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postLogin,
      body: {
        NameX.email: email,
        NameX.password: password,
      },
    );
    return UserX.fromJson(data.$1[NameX.userData], data.$1[NameX.token]);
  }

  static Future<String?> forgetPassword({required String email}) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postForgotPassword,
      body: {NameX.email: email},
    );
    return data.$2;
  }

  static Future<String?> forgetPasswordReset({
    required ForgetPasswordResetFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postForgotPasswordReset,
      body: form.toJson(),
      param: DataSourceParamX(
        authToken: form.token,
      ),
    );
    return data.$2;
  }

  static Future<UserX> forgetPasswordOtpCheckCode({
    required ForgetPasswordOtpCheckCodeFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postForgotPasswordOtpCheckCode,
      body: form.toJson(),
    );
    return UserX.fromJson(data.$1[NameX.userData], data.$1[NameX.token]);
  }

  static Future<String?> updatePassword({
    required UpdatePasswordFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postUpdatePassword,
      body: form.toJson(),
    );
    return data.$2;
  }

  static Future<String?> logout() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getLogout,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        ignoreUnauthorized: true,
        ignoreError: true,
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Profile

  static Future<UserX> getProfile() async {
    try {
      var data = await RemoteDataSourceX.get(
        DBEndPointX.getProfile,
        param: DataSourceParamX(
          maxRetries: 2,
          localCacheKey: 'profile',
          localCacheMaxAge: const Duration(days: 3),
          authToken: LocalDataX.token,
        ),
      );
      return UserX.fromJson(
        Map<String, dynamic>.from(data.$1),
        LocalDataX.token,
      );
    } catch (error) {
      if (error.toErrorX.errorCode == ErrorCodesX.unauthorized) {
        AppControllerX app = Get.find();
        await app.logOut();
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  static Future<String?> updateProfile({
    required UpdateProfileFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postUpdateProfile,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
      ),
    );
    return data.$2;
  }

  static Future<String?> uploadProfileImage({
    required File image,
  }) async {
    var data = await RemoteDataSourceX.postFiles(
      DBEndPointX.postUpdateImage,
      {NameX.photo: image},
      param: DataSourceParamX(
        authToken: LocalDataX.token,
      ),
    );
    return data.$2;
  }

  static Future<String?> deleteProfileImage() async {
    var data = await RemoteDataSourceX.delete(
      DBEndPointX.deleteProfileImage,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Statistics

  static Future<StatisticsX> getStatistics() async {
    try {
      var data = await RemoteDataSourceX.get(
        DBEndPointX.getStatistics,
        param: DataSourceParamX(
            localCacheKey: 'statistics',
            localCacheMaxAge: const Duration(days: 3),
            authToken: LocalDataX.token,
        ),
      );
      return StatisticsX.fromJson(data.$1);
    }catch(_){
      return StatisticsX(meetingCount: 0, newMeetingCount: 0);
    }
  }

  //============================================================================
  // Meeting

  static Future<
      (
        MeetingX meeting,
        AttendanceX attendance,
        List<String> permissions,
      )> getMeetingDetails({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getMeetingDetails,
      param: DataSourceParamX(
        localCacheKey: 'meeting-$id',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        pathParams: {
          NameX.id: id,
        },
      ),
    );
    return (
      MeetingX.fromJson(
        Map<String, dynamic>.from(data.$1[NameX.meeting]),
      ),
      AttendanceX.fromJson(
        Map<String, dynamic>.from(data.$1[NameX.attendance]),
      ),
      List<String>.from(data.$1[NameX.permissions] ?? [])
    );
  }

  static Future<List<MeetingX>> getAllMeetings({
    int page = 1,
    int perPage = 15,
    MeetingStatusStatusX? status,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllMeetings,
      param: DataSourceParamX(
        page: page,
        limit: perPage,
        localCacheKey: 'all_meetings_$page',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        filterParams: {
          NameX.status: status?.name ?? '',
        },
      ),
    );
    return ModelUtilX.generateItems(
      (data.$1[NameX.meetings]?[NameX.data]) ?? [],
      MeetingX.fromJson,
    );
  }

  static Future<List<MeetingX>> getAllRecurringMeetings({
    int page = 1,
    int perPage = 15,
  }) async {
    try{
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllRecurringMeetings,
      param: DataSourceParamX(
        page: page,
        limit: perPage,
        localCacheKey: 'all_recurring_meetings_$page',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(
      (data.$1[NameX.meetings]?[NameX.data]) ?? [],
      MeetingX.fromJson,
    );
    } catch (error) {
      if (error.toErrorX.errorCode == ErrorCodesX.unauthorized) {
        AppControllerX app = Get.find();
        await app.logOut();
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  static Future<List<MeetingX>> getAllMyMeetings({
    int page = 1,
    int perPage = 15,
    MeetingStatusStatusX? status,
  }) async {
    try{
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllMyMeetings,
      param: DataSourceParamX(
        page: page,
        limit: perPage,
        localCacheKey: 'all_my_meetings_$page',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        filterParams: {
          NameX.status: status?.name ?? '',
        },
      ),
    );
    return ModelUtilX.generateItems(
      (data.$1[NameX.meetings]?[NameX.data]) ?? [],
      MeetingX.fromJson,
    );
    } catch (error) {
      if (error.toErrorX.errorCode == ErrorCodesX.unauthorized) {
        AppControllerX app = Get.find();
        await app.logOut();
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  static Future<List<MeetingX>> getAllNewMeetings() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllNewMeetings,
      param: DataSourceParamX(
        localCacheKey: 'new_meetings',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.newMeeting] ?? [],
      MeetingX.fromJson,
    );
  }
  static Future<String?> addSignatureMeetingMinutes(String meetingId) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postAddSignatureMeetingMinutes,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {
          NameX.id:meetingId,
        }
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Attendance

  static Future<List<AttendanceX>> getAllAttendancesByMeetingId({
    required String meetingId,
    int page = 1,
    int perPage = 15,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAttendancesByMeetingId,
      param: DataSourceParamX(
          localCacheKey: 'DelegateUsersOfMeeting-$meetingId-$page',
          localCacheMaxAge: const Duration(days: 3),
          page: page,
          limit: perPage,
          authToken: LocalDataX.token,
          pathParams: {
            NameX.id: meetingId,
          }),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.attendance]?[NameX.data],
      AttendanceX.fromJson,
    );
  }

  static Future<String?> confirmAttendance({
    required ConfirmAttendanceFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postConfirmAttendance,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
        pathParams: {
          NameX.id: form.attendanceId,
        },
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Users

  static Future<List<MiniUserX>> getAttendanceUsersOfMeeting({
    required String meetingId,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAttendanceUsersOfMeeting,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {
          NameX.id: meetingId,
        },
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.members] ?? [],
      MiniUserX.fromJson,
    );
  }

  static Future<List<MiniUserX>> getDelegateUsersOfMeeting({
    required String meetingId,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDelegateUsersOfMeeting,
      param: DataSourceParamX(
        localCacheKey: 'DelegateUsersOfMeeting-$meetingId',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        pathParams: {
          NameX.id: meetingId,
        },
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.users] ?? [],
      MiniUserX.fromJson,
    );
  }

  //============================================================================
  // Rate

  static Future<String?> addRate(
      {required AddRateFormX form, required String meetingId}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.postMeetingRate,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
        pathParams: {
          NameX.id: meetingId,
        },
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Task

  static Future<List<TaskX>> getAllTasks() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllTasks,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.task] ?? [],
      TaskX.fromJson,
    );
  }

  //============================================================================
  // Dashboard

  static Future<DashboardX> getDashboard() async {
    try{
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDashboard,
      param: DataSourceParamX(
        localCacheKey: 'Dashboard',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return DashboardX.fromJson(Map<String, dynamic>.from(data.$1));
    } catch (error) {
      if (error.toErrorX.errorCode == ErrorCodesX.unauthorized) {
        AppControllerX app = Get.find();
        await app.logOut();
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  //============================================================================
  // Notifications

  static Future<(int count, List<NotificationX> notifiction)>
      getAllNotifications() async {
    try{
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getNotifications,
      param: DataSourceParamX(
        localCacheKey: 'Notifications',
        localCacheMaxAge: const Duration(days: 3),
        languageCode: TranslationX.getLanguageCode,
        authToken: LocalDataX.token,
      ),
    );
    int count = data.$1?[NameX.count] ?? 0;
    List<NotificationX> notifications = ModelUtilX.generateItems(
      data.$1[NameX.myNotifications],
      NotificationX.fromJson,
    );
    return (count, notifications);
    }catch(_){
      return (0,<NotificationX>[]);
    }
  }

  static Future<String?> updateReadNotifications({int? notifiableId}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getMarkAsReadNotifications,
      param: DataSourceParamX(authToken: LocalDataX.token, pathParams: {
        NameX.id: notifiableId.toStrDefaultX(''),
      }),
    );
    return data.$2;
  }

  static Future<String?> postNotificationSettings({
    required NotificationSettingsFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postNotificationsSettings,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Automatic Attendances

  static Future<String?> updateAutomaticAttendances({
    required bool active,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postAutomaticAttendances,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: {
          NameX.automaticAttendances: active,
        },
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Attachment

  static Future<(AttachmentX attachment, String? message)> uploadAttachment({
    required File file,
  }) async {
    var data = await RemoteDataSourceX.postFiles(
      DBEndPointX.postUploadAttachment,
      {NameX.link: file},
      param: DataSourceParamX(
        authToken: LocalDataX.token,
      ),
    );
    AttachmentX attachment = AttachmentX.fromJson(data.$1[NameX.attachment]);
    return (attachment, data.$2);
  }

  //============================================================================
  // Suggestion - الاقتراحات

  static Future<String?> addSuggestion({
    required AddSuggestionFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postAddSuggestions,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
      ),
    );
    return data.$2;
  }

  static Future<String?> addMeetingSuggestion({
    required AddMeetingSuggestionFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postAddMeetingSuggestion,
      param: DataSourceParamX(
          authToken: LocalDataX.token,
          requestBody: form.toJson(),
          pathParams: {
            NameX.id: form.meetingId,
          }),
    );
    return data.$2;
  }

  static Future<List<SuggestionX>> getAllSuggestions({
    int page = 1,
    int perPage = 15,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllSuggestions,
      param: DataSourceParamX(
        localCacheKey: 'suggestion-$page',
        localCacheMaxAge: const Duration(days: 3),
        page: page,
        limit: perPage,
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.suggestions]?[NameX.data],
      SuggestionX.fromJson,
    );
  }

  static Future<SuggestionX> getSuggestionDetails({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getSuggestionDetails,
      param: DataSourceParamX(
        localCacheKey: 'suggestion-$id',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        pathParams: {
          NameX.id: id,
        },
      ),
    );
    return SuggestionX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.suggestion]),
    );
  }

  static Future<String?> deleteSuggestion({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.delete(
      DBEndPointX.deleteSuggestion,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {
          NameX.id: id,
        },
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Signatures

  static Future<SignatureX?> getSignature() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getMySignature,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
      ),
    );
    var x = data.$1[NameX.user]?[NameX.signature];
    if (x != null) {
      return SignatureX(id: '', imageUrl: x.toString());
    }
    return null;
  }

  static Future<String?> addSignature({required File image}) async {
    var data = await RemoteDataSourceX.postFiles(
      DBEndPointX.postAddSignature,
      {NameX.signatureImage: image},
      param: DataSourceParamX(
        authToken: LocalDataX.token,
      ),
    );
    return data.$2;
  }

  static Future<String?> deleteAllSignature() async {
    var data = await RemoteDataSourceX.delete(
      DBEndPointX.deleteMySignature,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Questions

  static Future<List<QuestionX>> getAllQuestionsByMeeting({
    required String meetingId,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllQuestionsByMeeting,
      param: DataSourceParamX(authToken: LocalDataX.token, pathParams: {
        NameX.id: meetingId,
      }),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.questions],
      QuestionX.fromJson,
    );
  }

  //============================================================================
  // Agenda

  static Future<List<AgendaX>> getAgendaByMeeting({
    required String meetingId,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAgendaByMeeting,
      param: DataSourceParamX(authToken: LocalDataX.token, pathParams: {
        NameX.id: meetingId,
      }),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.gendas],
      AgendaX.fromJson,
    );
  }

  //============================================================================
  // Vote

  static Future<String?> sendMeetingVoteQuestions({
    required MeetingVoteQuestionsFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postMeetingVoteQuestions,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
        pathParams: {
          NameX.id: form.meetingId,
        },
      ),
    );
    return data.$2;
  }

  static Future<String?> sendMeetingVoteDelegateQuestions({
    required MeetingVoteDelegateQuestionsFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postMeetingDelegateVoteQuestions,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
        pathParams: {
          NameX.id: form.meetingId,
        },
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Delegate

  static Future<List<DelegateX>> getAllDelegates({
    int page = 1,
    int perPage = 15,
  }) async {
    try{
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllDelegates,
      param: DataSourceParamX(
        page: page,
        limit: perPage,
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.delegate]?[NameX.data],
      DelegateX.fromJson,
    );
    } catch (error) {
      if (error.toErrorX.errorCode == ErrorCodesX.unauthorized) {
        AppControllerX app = Get.find();
        await app.logOut();
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  static Future<DelegateX> getDelegateDetails({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDelegateDetails,
      param: DataSourceParamX(
        pathParams: {NameX.id: id},
        authToken: LocalDataX.token,
      ),
    );
    return DelegateX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.delegate]),
    );
  }

  static Future<String?> confirmDelegate({
    required String id,
    required bool isConfirm,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postConfirmDelegate,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.id: id},
        requestBody: {
          NameX.status: isConfirm,
        },
      ),
    );
    return data.$2;
  }
}
