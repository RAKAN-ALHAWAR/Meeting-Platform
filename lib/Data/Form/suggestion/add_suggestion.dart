import 'package:meeting/Data/data.dart';

class AddSuggestionFormX {
  final String title;
  final String message;
  final List<int> attachmentsId;

  AddSuggestionFormX({
    required this.title,
    required this.message,
    required this.attachmentsId,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.title: title,
      NameX.message: message,
      NameX.attachments: attachmentsId,
    };
  }
}
