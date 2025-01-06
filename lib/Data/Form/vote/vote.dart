import 'package:meeting/Data/data.dart';

class MeetingVoteQuestionsFormX {
  final String meetingId;
  final List<int> questionsIDs;
  final List<int> answersIds;

  MeetingVoteQuestionsFormX({
    required this.meetingId,
    required this.questionsIDs,
    required this.answersIds,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.questions: [
        for (int i = 0; i < questionsIDs.length; i++)
          {NameX.questionId: questionsIDs[i], NameX.id: answersIds[i]}
      ],
    };
  }
}
