enum NotificationTypeStatusX {
  newMeeting('after_the_meeting_creation_process'),
  alertMeeting('alerts_before_the_meeting'),
  editMeeting('after_the_meeting_updation_process'),
  cancelledMeeting('if_the_meeting_is_cancelled'),
  confirmAttendanceMeeting('confirm_attendance_if_not_confirmed'),
  minutesMeeting('minutes_of_the_meeting'),
  requestsDelegate('power_of_attorney_requests'),
  responseDelegate('response_power_of_attorney_requests'),
  alertPublishMeeting('alert_the_administrator_to_post_the_meeting'),
  voteMeeting('meeting_evaluation'),
  addSuggestion('letters_of_thanks_for_proposals'),
  newTask('mission'),
  other('newNotification');

  final String name;
  const NotificationTypeStatusX(this.name);
}
