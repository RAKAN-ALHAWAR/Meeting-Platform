import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

class RepetitionX {
  final List<String> days;
  final List<DateTime> dates;
  final List<String> weekDays;
  final int? monthDay;

  RepetitionX({
    this.days = const [],
    this.dates = const [],
    this.weekDays = const [],
    this.monthDay,
  });

  factory RepetitionX.fromJson(Map<String, dynamic> json) {
    List<DateTime> datesList = List<DateTime>.from(((json[NameX.data]??[])as List).map((e) => e.toDateTimeX).toList());

    return ModelUtilX.checkFromJson(
      json,
      (json) => RepetitionX(
        days: List<String>.from((json[NameX.day]??[])as List),
        dates: datesList,
        weekDays: List<String>.from((json[NameX.weekDay]??[])as List),
        monthDay: json[NameX.monthDay].toIntNullableX,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.day: days,
      NameX.date: dates.map((e) => e.toIso8601String()).toList(),
      NameX.weekDay: weekDays,
      NameX.monthDay: monthDay,
    };
  }
}
