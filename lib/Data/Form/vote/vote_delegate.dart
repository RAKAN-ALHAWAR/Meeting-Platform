import 'package:meeting/Data/data.dart';

class MeetingVoteDelegateQuestionsFormX {
  final String meetingId;
  final String delegateId;
  final List<int> questionsIDs;
  final List<int> answersIds;

  MeetingVoteDelegateQuestionsFormX({
    required this.meetingId,
    required this.delegateId,
    required this.questionsIDs,
    required this.answersIds,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.attdelegate:delegateId,
      NameX.questions: [
        for (int i = 0; i < questionsIDs.length; i++)
          {NameX.questionId: questionsIDs[i], NameX.id: answersIds[i]}
      ],
    };
  }
}
