enum NotificationTypeStatusX {
  newMeeting('after_the_meeting_creation_process'),
  alertMeeting('after_the_meeting_creation_process'),
  cancelledMeeting('if_the_meeting_is_cancelled'),
  confirmAttendanceMeeting('confirm_attendance_if_not_confirmed'),
  online('minutes_of_the_meeting'),
  minutesMeeting('power_of_attorney_requests'),
  requestsDelegate('alert_the_administrator_to_post_the_meeting'),
  responseDelegate('after_the_meeting_updation_process'),
  alertPublishMeeting('response_power_of_attorney_requests'),
  voteMeeting('meeting_evaluation'),
  addSuggestion('letters_of_thanks_for_proposals'),
  newTask('mission'),
  other('newNotification');

  final String name;
  const NotificationTypeStatusX(this.name);
}
