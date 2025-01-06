import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Core/Error/error.dart';
import 'package:meeting/Data/Form/attendance/confirm_attendance.dart';
import 'package:meeting/Data/Form/vote/vote.dart';
import 'package:meeting/Data/Form/vote/vote_delegate.dart';
import 'package:meeting/Data/Model/attendance/attendance.dart';
import 'package:meeting/Data/Model/delegate/delegate.dart';
import 'package:meeting/Data/Model/meeting/meeting.dart';
import 'package:meeting/Data/Model/meeting/sub/question.dart';
import 'package:meeting/Data/Model/user/mini_user.dart';
import 'package:meeting/Data/data.dart';
import 'package:http/http.dart' as http;

import '../../../../../Config/config.dart';
import '../../../../../Core/Service/firebaseRemoteConfigService.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Enum/ability_status.dart';
import '../../../../../Data/Enum/attendance_status_status.dart';
import '../../../../../Data/Form/suggestion/add_meeting_suggestion.dart';
import '../../../../../Data/Model/attachment/attachment.dart';
import '../../../../../Data/Model/suggestion/suggestion.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../ScreenSheet/Delegate/SelectionDelegateUser/view/selectionDelegateUserSheet.dart';

class MeetingDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  /// Get Meeting Id
  String id = Get.arguments.toString();

  /// Main variables
  late Rx<MeetingX> meeting;
  late Rx<AttendanceX> myAttendance;
  Rx<SuggestionX?> mySuggestion = Rx(null);
  Rx<DelegateX?> myDelegate = Rx(null);

  /// List variables
  RxList<AttendanceX> attendances = <AttendanceX>[].obs;
  RxList<(int, int)> myAnswersIDs = <(int, int)>[].obs;
  RxList<MiniUserX> delegateUsers = <MiniUserX>[].obs;
  RxList<QuestionX> questions = <QuestionX>[].obs;
  RxList<String> fileSizes = <String>[].obs;
  RxList<String> permissions = <String>[].obs;

  /// Boolean variables
  RxBool isLoading = false.obs;
  RxBool isOngoingMeeting = false.obs;
  RxBool isClosedMeeting = false.obs;
  RxBool isUpcomingMeeting = false.obs;
  bool isDelegate = false;
  bool _isUpdatingData = false;

  /// Animation
  late AnimationController ongoingAnimationController;
  late Animation<double> ongoingAnimation;

  /// Time left for the meeting
  RxInt days = 0.obs;
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;

  /// Presence Status
  RxInt selectedPresenceStatus = (-1).obs;
  Rx<ButtonStateEX> buttonStatePresenceStatus = ButtonStateEX.normal.obs;
  RxBool isShowButtonEditPresenceStatus = false.obs;
  RxBool isEditPresenceStatus = false.obs;
  TextEditingController excusedCommentsPresenceStatus = TextEditingController();
  Rx<MiniUserX?> selectedDelegatedUser = Rx<MiniUserX?>(null);
  GlobalKey<FormState> formKeyPresenceStatus = GlobalKey();
  AutovalidateMode autoValidatePresenceStatus = AutovalidateMode.disabled;

  /// Vote
  Rx<ButtonStateEX> buttonStateVote = ButtonStateEX.normal.obs;
  RxBool isOpenVoting = false.obs;
  RxBool isEndVoting = false.obs;
  RxBool isVoted = false.obs;

  /// Tabs
  final tabs = ValueNotifier(1);
  RxInt tabsIndex = 1.obs;

  /// Suggestion
  GlobalKey<FormState> formKeySuggestion = GlobalKey();
  AutovalidateMode autoValidateSuggestion = AutovalidateMode.disabled;
  TextEditingController suggestionTitle = TextEditingController();
  TextEditingController suggestionDescription = TextEditingController();
  Rx<ButtonStateEX> buttonStateSuggestion = ButtonStateEX.normal.obs;

  /// Timers
  Timer? _countdownTimer;
  Timer? _statusUpdateTimer;
  Timer? _dataUpdateTimer;

  //============================================================================
  // Functions

  Future getData() async {
    await getMainData();
    startCountdown(meeting.value.startFullDate);
    startStatusUpdate();
    startPeriodicDataUpdate();
  }

  Future getMainData() async {
    /// Get Meeting & Attendance & Permissions Data
    var result = await DatabaseX.getMeetingDetails(id: id);
    meeting = result.$1.obs;
    myAttendance = result.$2.obs;
    permissions = result.$3.obs;

    /// questions
    questions.value = meeting.value.questions;

    /// delegate Users
    if (app.user.value.abilities.contains(AbilityStatusX.controlDelegate)) {
      delegateUsers.value = await DatabaseX.getDelegateUsersOfMeeting(
        meetingId: id,
      );
    }
    /// Get First Suggestion
    mySuggestion.value = meeting.value.suggestions.firstWhereOrNull(
      (x) => x.userId == app.user.value.id,
    );

    /// Attendances
    try {
      attendances.value = await DatabaseX.getAllAttendancesByMeetingId(
        meetingId: id,
      );
    } catch (_) {
      attendances.value = meeting.value.attendances;
    }

    /// Excused Comments
    excusedCommentsPresenceStatus.text = myAttendance.value.comments ?? '';

    /// Closed Meeting
    isClosedMeeting.value = meeting.value.isClosed;
    isVoted.value =
        myAttendance.value.isVote || myAttendance.value.isVoteDelegate;

    /// Upcoming Meeting
    isUpcomingMeeting.value =
        meeting.value.startFullDate.isAfter(DateTime.now()) &&
            isClosedMeeting.isFalse;

    /// get Attachment Sizes
    await getAllAttachmentSizes();

    /// TODO: الحصول على الاجابات السابقة الخاصة بي
    // myAnswersIDs.value = [];

    /// TODO: التحقق اذا كان مندوب ام لا
    isDelegate = false;

    /// TODO: جلب بيانات الموكل الخاص بي
    myDelegate.value = null;
  }

  onSendPresenceStatus() async {
    if (isLoading.isFalse && selectedPresenceStatus.value != -1) {
      if (selectedPresenceStatus.value == 2 &&
          selectedDelegatedUser.value == null) {
        ToastX.error(
          message:
              'You must select a client before updating your attendance status',
        );
      } else {
        if (formKeyPresenceStatus.currentState?.validate() ?? true) {
          try {
            buttonStatePresenceStatus.value = ButtonStateEX.loading;
            isLoading.value = true;

            /// Get Attendance Status
            late AttendanceStatusStatusX status;
            if (selectedPresenceStatus.value == 0) {
              status = AttendanceStatusStatusX.present;
            } else if (selectedPresenceStatus.value == 1) {
              status = AttendanceStatusStatusX.excused;
            } else if (selectedPresenceStatus.value == 2) {
              status = AttendanceStatusStatusX.byDelegated;
            }

            String? message = await DatabaseX.confirmAttendance(
              form: ConfirmAttendanceFormX(
                attendanceId: myAttendance.value.id,
                status: status,
                comments: selectedPresenceStatus.value == 1
                    ? excusedCommentsPresenceStatus.text
                    : null,
                delegatedUserId: selectedPresenceStatus.value == 2
                    ? selectedDelegatedUser.value?.id
                    : null,
              ),
            );

            myAttendance.value.status = status;
            if (selectedPresenceStatus.value == 1) {
              myAttendance.value.comments = excusedCommentsPresenceStatus.text;
            }
            if (selectedPresenceStatus.value == 2) {
              myDelegate.value =
                  DelegateX.local(delegated: selectedDelegatedUser.value);
            }
            isEditPresenceStatus.value = false;

            ToastX.success(
              message: message ?? 'Your presence status has been updated',
            );

            /// The time delay here is aesthetically beneficial
            buttonStatePresenceStatus.value = ButtonStateEX.success;
            await Future.delayed(
              const Duration(seconds: StyleX.successButtonSecond),
            );
          } catch (error) {
            buttonStatePresenceStatus.value = ButtonStateEX.failed;
            ToastX.error(message: error);
          }
          isLoading.value = false;

          /// Reset the button state
          Timer(
            const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
            () {
              buttonStatePresenceStatus.value = ButtonStateEX.normal;
            },
          );
        } else {
          autoValidatePresenceStatus = AutovalidateMode.always;
        }
      }
    }
  }

  onSendSuggestion() async {
    if (isLoading.isFalse) {
      if (formKeySuggestion.currentState!.validate()) {
        try {
          buttonStateSuggestion.value = ButtonStateEX.loading;
          isLoading.value = true;

          var message = await DatabaseX.addMeetingSuggestion(
            form: AddMeetingSuggestionFormX(
              title: suggestionTitle.text,
              description: suggestionDescription.text,
              meetingId: meeting.value.id,
            ),
          );

          /// Add Suggestion on Controller
          mySuggestion.value = SuggestionX(
            id: '',
            title: suggestionTitle.text.trim(),
            message: suggestionDescription.text.trim(),
            createdAt: DateTime.now(),
          );

          /// The time delay here is aesthetically beneficial
          buttonStateSuggestion.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          if (message != null) {
            ToastX.success(message: message);
          }
        } catch (e) {
          e.toErrorX.log();
          buttonStateSuggestion.value = ButtonStateEX.failed;
          ToastX.error(message: e.toString());
        }
        isLoading.value = false;

        /// Reset the button state
        Timer(
          const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
            buttonStateSuggestion.value = ButtonStateEX.normal;
          },
        );
      } else {
        autoValidateSuggestion = AutovalidateMode.always;
      }
    }
  }

  onSendVote() async {
    if (isLoading.isFalse) {
      if (allQuestionsHaveAnswers()) {
        try {
          buttonStateVote.value = ButtonStateEX.loading;
          isLoading.value = true;
          String? message;

          if (isDelegate) {
            message = await DatabaseX.sendMeetingVoteDelegateQuestions(
              form: MeetingVoteDelegateQuestionsFormX(
                questionsIDs: myAnswersIDs.map((x) => x.$1).toList(),
                answersIds: myAnswersIDs.map((x) => x.$2).toList(),
                meetingId: meeting.value.id,
                delegateId: app.user.value.id,
              ),
            );
          } else {
            message = await DatabaseX.sendMeetingVoteQuestions(
              form: MeetingVoteQuestionsFormX(
                questionsIDs: myAnswersIDs.map((x) => x.$1).toList(),
                answersIds: myAnswersIDs.map((x) => x.$2).toList(),
                meetingId: meeting.value.id,
              ),
            );
          }

          isVoted.value = true;

          /// The time delay here is aesthetically beneficial
          buttonStateVote.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          if (message != null) {
            ToastX.success(message: message);
          }
        } catch (e) {
          e.toErrorX.log();
          buttonStateVote.value = ButtonStateEX.failed;
          ToastX.error(message: e.toString());
        }
        isLoading.value = false;

        /// Reset the button state
        Timer(
          const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
            buttonStateVote.value = ButtonStateEX.normal;
          },
        );
      } else {
        ToastX.error(
          message:
              'Please answer all the questions before saving and submitting',
        );
      }
    }
  }

  onChangeTask(bool val) async {
    /// TODO: اضافة ربط انجاز المهام بقاعدة البيانات
  }

  bool allQuestionsHaveAnswers() {
    for (final question in questions) {
      final hasAnswer = myAnswersIDs.any((entry) => entry.$1 == question.id);
      if (!hasAnswer) {
        return false;
      }
    }
    return true;
  }

  onTapDelegateSelection() async {
    MiniUserX? result = await selectionDelegateUserSheet(
        users: delegateUsers, selectedUser: selectedDelegatedUser.value);
    if (result != null) {
      selectedDelegatedUser.value = result;
    }
  }

  bool get isShowPresenceStatus =>
      isOngoingMeeting.isFalse ||
      myAttendance.value.status != AttendanceStatusStatusX.present;
  bool get isShowNowOngoing =>
      isOngoingMeeting.isTrue &&
      myAttendance.value.status == AttendanceStatusStatusX.present;
  bool get isShowPresenceStatusButtons =>
      (myAttendance.value.status == AttendanceStatusStatusX.absent ||
          isEditPresenceStatus.isTrue) &&
      isClosedMeeting.isFalse;
  bool get isShowPresentCardPresenceStatus =>
      myAttendance.value.status == AttendanceStatusStatusX.present &&
      isClosedMeeting.isFalse &&
      isEditPresenceStatus.isFalse;
  bool get isShowDelegatedToSomeoneElsePresenceStatus =>
      myAttendance.value.status == AttendanceStatusStatusX.byDelegated &&
      isEditPresenceStatus.isFalse;
  bool get isShowMeetingAttendedPresenceStatus =>
      myAttendance.value.status == AttendanceStatusStatusX.present &&
      isClosedMeeting.isTrue &&
      isEditPresenceStatus.isFalse;
  bool get isShowAbsentFromMeetingPresenceStatus =>
      myAttendance.value.status == AttendanceStatusStatusX.absent &&
      isClosedMeeting.isTrue &&
      isEditPresenceStatus.isFalse;
  bool get isShowNonAttendanceMeetingPresenceStatus =>
      myAttendance.value.status == AttendanceStatusStatusX.excused &&
      isEditPresenceStatus.isFalse;
  bool get isDisableButtonOfSavePresenceStatus =>
      selectedPresenceStatus.value == 2 && selectedDelegatedUser.value == null;
  bool get isShowGeneralRecommendations =>
      meeting.value.isClosed &&
      meeting.value.agendas.where((x) => x.recommendContent != null).isNotEmpty;

  checkIsOngoing() {
    final now = DateTime.now();
    if (meeting.value.startFullDate.isBefore(now) &&
        meeting.value.endFullDate.isAfter(now)) {
      isOngoingMeeting.value = true;
    } else {
      isOngoingMeeting.value = false;
    }
  }

  checkIsOpenVoting() {
    if (meeting.value.voteStartAt != null && meeting.value.voteEndAt != null) {
      final now = DateTime.now();
      if (meeting.value.voteStartAt!.isBefore(now) &&
          meeting.value.voteEndAt!.isAfter(now)) {
        isOpenVoting.value = true;
      } else {
        isOpenVoting.value = false;
      }
    } else {
      isOpenVoting.value = false;
    }
  }

  checkIsEndVoting() {
    if (meeting.value.voteEndAt != null) {
      final now = DateTime.now();
      isEndVoting.value = now.isAfter(meeting.value.voteEndAt!);
    } else {
      isEndVoting.value = false;
    }
  }

  checkIsShowEditPresenceStatus() {
    if (myAttendance.value.status != AttendanceStatusStatusX.absent &&
        isClosedMeeting.isFalse) {
      isShowButtonEditPresenceStatus.value = true;
    } else {
      isShowButtonEditPresenceStatus.value = false;
    }
  }

  onTapEditPresenceStatus() {
    isEditPresenceStatus.value = !isEditPresenceStatus.value;
  }

  onChangePresenceStatusSelected(int i) {
    selectedPresenceStatus.value = i;
  }

  onTapAttachment(AttachmentX attachment) {
    Get.toNamed(RouteNameX.fileReader, arguments: attachment);
  }

  openMeeting() {
    Get.toNamed(
      RouteNameX.myWebView,
      arguments: meeting.value.locationOnlineUrl,
    );
  }

  openMinutesMeeting() {
    Get.toNamed(RouteNameX.meetingMinutes, arguments: meeting.value.id);
  }

  Future<void> getAllAttachmentSizes() async {
    fileSizes.value = [];
    for (var x in meeting.value.attachments) {
      fileSizes.add((await getAttachmentSize(x)));
    }
  }

  Future<String> getAttachmentSize(AttachmentX attachment) async {
    int? size;
    try {
      final response = await http.head(Uri.parse(getAttachmentUrl(attachment)));
      if (response.statusCode == 200) {
        final contentLength = response.headers['content-length'];
        if (contentLength != null) {
          size = int.tryParse(contentLength);
        }
      }
    } catch (_) {}
    if (size != null) {
      var x = FunctionX.formatFileSize(size);
      return '${x.$1} ${x.$2.tr}';
    } else {
      return '';
    }
  }

  String getAttachmentUrl(AttachmentX attachment) {
    if (attachment.path.isURL) {
      return attachment.path;
    } else {
      var url = FirebaseRemoteConfigServiceX.getString('base_url');
      int endIndex = url.indexOf('.com');
      if (endIndex != -1) {
        return '${url.substring(0, endIndex + 4)}/${attachment.path}';
      } else {
        return '$url/${attachment.path}'.trim();
      }
    }
  }

  void startCountdown(DateTime meetingStart) {
    _updateCountdownValues(meetingStart);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCountdownValues(meetingStart);
    });
  }

  void _updateCountdownValues(DateTime meetingStart) {
    final now = DateTime.now();
    final difference = meetingStart.difference(now);

    if (difference.isNegative) {
      _countdownTimer?.cancel();
      days.value = 0;
      hours.value = 0;
      minutes.value = 0;
      seconds.value = 0;
      isUpcomingMeeting.value = false;
      return;
    }

    days.value = difference.inDays;
    hours.value = difference.inHours % 24;
    minutes.value = difference.inMinutes % 60;
    seconds.value = difference.inSeconds % 60;
  }

  void startStatusUpdate() {
    _updateStatusValues();
    _statusUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateStatusValues();
    });
  }

  void _updateStatusValues() {
    final now = DateTime.now();

    isUpcomingMeeting.value =
        meeting.value.startFullDate.isAfter(now) && isClosedMeeting.isFalse;

    checkIsOngoing();
    checkIsOpenVoting();
    checkIsEndVoting();
    checkIsShowEditPresenceStatus();
  }

  void startPeriodicDataUpdate() {
    _dataUpdateTimer?.cancel();
    _dataUpdateTimer =
        Timer.periodic(const Duration(seconds: 60), (timer) async {
      if (_isUpdatingData) return;
      _isUpdatingData = true;
      try {
        await getMainData();
      } catch (_) {
      } finally {
        _isUpdatingData = false;
      }
    });
  }
  //============================================================================
  // Initialization

  @override
  void onInit() {
    tabs.addListener(() {
      tabsIndex.value = tabs.value;
    });
    ongoingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    ongoingAnimation = Tween<double>(begin: 0.9, end: 1.2).animate(
      CurvedAnimation(
        parent: ongoingAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    ongoingAnimationController.dispose();
    _countdownTimer?.cancel();
    _statusUpdateTimer?.cancel();
    _dataUpdateTimer?.cancel();
    super.onClose();
  }
}
