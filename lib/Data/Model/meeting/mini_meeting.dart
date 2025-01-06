import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/data.dart';

import '../../Enum/meeting_place_status.dart';

class MiniMeetingX {
  MiniMeetingX({
    required this.id,
    required this.title,
    this.number,
    this.date,
    this.startAt,
    this.endAt,
    this.place,
    this.locationOnlineUrl,
    this.locationLocale,
  });

  final int id;
  final String title;
  final int? number;
  final DateTime? date;
  final TimeOfDay? startAt;
  final TimeOfDay? endAt;
  final MeetingPlaceStatusX? place;
  final String? locationOnlineUrl;
  final String? locationLocale;
  factory MiniMeetingX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => MiniMeetingX(
        id: json[NameX.id].toIntX,
        title: json[NameX.title].toStrX,
        number: json[NameX.number].toIntNullableX,
        date: json[NameX.date].toDateTimeNullableX,
        startAt: json[NameX.startAt].toTimeOfDayNullableX,
        endAt: json[NameX.endAt].toTimeOfDayNullableX,
        place: MeetingPlaceStatusX.values.firstWhereOrNull(
          (x) => x.name == json[NameX.place].toStrX.toLowerCase(),
        ),
        locationOnlineUrl: json[NameX.link].toStrNullableX,
        locationLocale: json[NameX.locale].toStrNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.title,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.title: title,
      NameX.number: number,
    };
  }
}
