import 'package:meeting/Data/data.dart';

class AddMeetingSuggestionFormX {
  final String title;
  final String description;
  final String meetingId;

  AddMeetingSuggestionFormX({
    required this.title,
    required this.description,
    required this.meetingId,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.meetingSuggestions:[
        {
          NameX.title: title,
          NameX.description: description,
        }
      ]
    };
  }
}
