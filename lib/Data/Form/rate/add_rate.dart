import 'package:meeting/Data/data.dart';

class AddRateFormX {
  final int rate;
  final String? comment;

  AddRateFormX({
    required this.rate,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.rate: rate,
      if(comment!=null)
      NameX.comment: comment,
    };
  }
}
