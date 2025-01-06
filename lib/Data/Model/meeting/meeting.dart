import 'package:flutter/material.dart';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Helper/model/model.dart';
import 'package:meeting/Data/Model/meeting/sub/rate.dart';
import 'package:meeting/Data/Model/meeting/sub/repetition.dart';
import 'package:meeting/Data/data.dart';

import '../../Enum/meeting_place_status.dart';
import '../../Enum/meeting_status_status.dart';
import '../../Enum/repetition_type_status.dart';
import '../User/role.dart';
import '../User/user.dart';
import '../attachment/attachment.dart';
import '../attendance/attendance.dart';
import '../dashboard/task.dart';
import '../suggestion/suggestion.dart';
import 'meeting_type.dart';
import 'sub/agenda.dart';
import 'sub/question.dart';
import 'sub/visitor.dart';
class MeetingX {
  /// معرف الاجتماع
  final String id;
  /// عنوان الاجتماع
  final String title;
  /// الوصف
  final String description;
  /// حالة الاجتماع
  final MeetingStatusStatusX statusName;

  /// تاريخ الاجتماع
  final DateTime date;
  /// وقت بدء الاجتماع
  final TimeOfDay startAt;
  /// وقت انتهاء الاجتماع
  final TimeOfDay endAt;

  /// تاريخ ووقت بدء الاجتماع
  late final DateTime startFullDate;
  /// تاريخ ووقت انتهاء الاجتماع
  late final DateTime endFullDate;

  /// نوع الاجتماع
  final MeetingTypeX type;
  /// معرف نوع الاجتماع
  final int typeId;
  /// رقم الاجتماع بحسب النوع
  final int numberMeetingByType;

  /// مكان الاجتماع
  final MeetingPlaceStatusX place;
  /// رابط الاجتماع على الاونلاين
  final String? locationOnlineUrl;
  /// مكان الاجتماع على ارض الواقع
  final String? locationLocale;

  /// اذا تم اغلاق الاجتماع
  final bool isClosed;
  /// اذا كان الاجتماع مهمل
  final bool isDraft;
  /// اذا تم اغلاق المحضر
  final bool isCloseRecord;
  /// اذا تم تفعيل الاقتراحات
  final bool isSuggestion;

  /// تاريخ النشر
  final DateTime? publishingAt;
  /// تاريخ الانشاء
  final DateTime? createdAt;
  /// تاريخ التعديل
  final DateTime? updatedAt;
  /// تاريخ الحذف
  final DateTime? deletedAt;

  /// معرف الاجتماع على التقويم
  final String? googleCalendarEventId;

  /// معرف المستخدم الذي انشئ الاجتماع
  final int creatorId;
  /// المستخدم الذي انشئ الاجتماع
  final UserX? created;
  /// معرف ادمن الاجتماع
  final int? adminId;
  /// ادمن الاجتماع
  final UserX? admin;

  /// اذا التصويت مفتوح
  final bool isVote;
  /// تاريخ بدء التصويت
  final DateTime? voteStartAt;
  /// تاريخ انتهاء التصويت
  final DateTime? voteEndAt;

  /// نوع التكرار
  final RepetitionTypeStatusX repetitionType;
  /// ايام وتفاصيل التكرار المستبعدة
  final RepetitionX repetition;
  /// عدد تكرارات الاجتماع
  final int repeatDuration;

  /// عدد الحضور
  final int attendancesCount;
  /// عدد المندوبين
  final int delegatesCount;
  /// عدد الاسئلة
  final int questionsCount;

  /// التقييم
  final RateX? rate;
  /// المهام
  final List<TaskX> tasks;
  /// الزوار
  final List<VisitorX> visitors;
  /// الصلاحيات
  final List<RoleX> roles;
  /// قائمة الحضور
  final List<AttendanceX> attendances;
  /// الملفات المرفقة
  final List<AttachmentX> attachments;
  /// الاسئلة
  final List<QuestionX> questions;
  /// الاقتراحات
  final List<SuggestionX> suggestions;
  /// الاجندة
  final List<AgendaX> agendas;

  MeetingX({
    required this.id,
    required this.title,
    required this.description,
    required this.statusName,
    required this.date,
    required this.startAt,
    required this.endAt,
    required this.type,
    required this.typeId,
    required this.numberMeetingByType,
    required this.place,
    this.locationOnlineUrl,
    this.locationLocale,
    required this.isClosed,
    required this.isDraft,
    required this.isCloseRecord,
    required this.isSuggestion,
    this.publishingAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.googleCalendarEventId,
    required this.creatorId,
    this.created,
    this.adminId,
    this.admin,
    required this.isVote,
    this.voteStartAt,
    this.voteEndAt,
    required this.repetitionType,
    required this.repetition,
    required this.repeatDuration,
    required this.attendancesCount,
    required this.delegatesCount,
    required this.questionsCount,
    this.rate,
    required this.tasks,
    required this.visitors,
    required this.roles,
    required this.attendances,
    required this.attachments,
    required this.questions,
    required this.suggestions,
    required this.agendas,
  }){
    startFullDate = DateTime(
      date.year,
      date.month,
      date.day,
      startAt.hour,
      startAt.minute,
    );
    endFullDate = DateTime(
      date.year,
      date.month,
      date.day,
      endAt.hour,
      endAt.minute,
    );
  }

  factory MeetingX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> typeJson =
    Map<String, Object?>.from(json[NameX.type] ?? {});

    Map<String, Object?> repetitionJson =
    Map<String, Object?>.from(json[NameX.repetition] ?? {});
    List<Map<String, dynamic>> tasksJsonList = List<Map<String, dynamic>>.from((json[NameX.tasks] is List ? json[NameX.tasks] : [])
        .map((item) => (item as Map).map(
          (key, value) => MapEntry(key.toString(), value),
    )).toList());


    List<Map<String, dynamic>> visitorsJsonList = List<Map<String, dynamic>>.from((json[NameX.visitors] is! List ? [] : json[NameX.visitors]) as List);
    List<Map<String, dynamic>> rolesJsonList = List<Map<String, dynamic>>.from((json[NameX.roles] is! List ? [] : json[NameX.roles]) as List);
    List<Map<String, dynamic>> attendancesJsonList = List<Map<String, dynamic>>.from((json[NameX.attendances] is List ? json[NameX.attendances] : [])
        .map((item) => (item as Map).map(
          (key, value) => MapEntry(key.toString(), value),
    )).toList());


    List<Map<String, dynamic>> attachmentsJsonList = List<Map<String, dynamic>>.from((json[NameX.attachments] is! List ? [] : json[NameX.attachments]) as List);
    List<Map<String, dynamic>> questionsJsonList = List<Map<String, dynamic>>.from((json[NameX.questions] is! List ? [] : json[NameX.questions]) as List);
    List<Map<String, dynamic>> suggestionsJsonList = List<Map<String, dynamic>>.from((json[NameX.suggestions] is! List ? [] : json[NameX.suggestions]) as List);
    List<Map<String, dynamic>> agendasJsonList = List<Map<String, dynamic>>.from((json[NameX.agendas] is! List ? [] : json[NameX.agendas]) as List);

      return ModelUtilX.checkFromJson(
        json,
            (json) => MeetingX(
          id: json[NameX.id].toStrX,
          title: json[NameX.title].toStrX,
          description: json[NameX.shortDescription].toStrDefaultX(''),
          statusName: MeetingStatusStatusX.values.firstWhere((x) => x.name==json[NameX.statusName].toString().toLowerCase(),orElse: ()=>MeetingStatusStatusX.other),
          date: json[NameX.date].toDateTimeX,
          startAt: json[NameX.startAt].toTimeOfDayX,
          endAt: json[NameX.endAt].toTimeOfDayX,
          type: MeetingTypeX.fromJson(typeJson),
          typeId: json[NameX.typeId].toIntX,
          numberMeetingByType: json[NameX.number].toIntX,
          place: MeetingPlaceStatusX.values.firstWhere((x) => x.name==json[NameX.place].toStrX.toLowerCase()),
          locationOnlineUrl: json[NameX.link].toStrNullableX,
          locationLocale: json[NameX.locale].toStrNullableX,
          isClosed: json[NameX.isClosed].toBoolX,
          isDraft: json[NameX.isDraft].toBoolX,
          isCloseRecord: json[NameX.closeRecord].toBoolX,
          isSuggestion: json[NameX.enableSuggestion].toBoolX,
          publishingAt: json[NameX.publishingAt].toDateTimeNullableX,
          createdAt: json[NameX.createdAt].toDateTimeNullableX,
          updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
          deletedAt: json[NameX.deletedAt].toDateTimeNullableX,
          googleCalendarEventId: json[NameX.googleCalendarEventId].toStrNullableX,
          creatorId: json[NameX.creator].toIntX,
          created: json[NameX.createdBy].toFromJsonNullableX((x)=>UserX.fromJson(x,'')),
          adminId: json[NameX.adminId].toIntNullableX,
          admin: json[NameX.admin].toFromJsonNullableX((x)=>UserX.fromJson(x,'')),
          isVote: json[NameX.enableVote].toBoolX,
          voteStartAt: json[NameX.voteAt].toDateTimeNullableX,
          voteEndAt: json[NameX.voteEndAt].toDateTimeNullableX,
          repetitionType: RepetitionTypeStatusX.values.firstWhere((x) => x.name==json[NameX.repetitionType].toStrX.toLowerCase()),
          repetition: RepetitionX.fromJson(repetitionJson),
          repeatDuration: json[NameX.repeatDuration].toIntDefaultX(1),
          attendancesCount: json[NameX.attendancesCount].toIntDefaultX(0),
          delegatesCount: json[NameX.delegatesCount].toIntDefaultX(0),
          questionsCount: json[NameX.questionsCount].toIntDefaultX(0),
          rate: json[NameX.rate].toFromJsonNullableX(RateX.fromJson),
          tasks: ModelUtilX.generateItems(tasksJsonList, TaskX.fromJson),
          visitors: ModelUtilX.generateItems(visitorsJsonList, VisitorX.fromJson),
          roles: ModelUtilX.generateItems(rolesJsonList, RoleX.fromJson),
          attendances: ModelUtilX.generateItems(attendancesJsonList, AttendanceX.fromJson),
          attachments: ModelUtilX.generateItems(attachmentsJsonList, AttachmentX.fromJson),
          questions: ModelUtilX.generateItems(questionsJsonList, QuestionX.fromJson),
          suggestions: ModelUtilX.generateItems(suggestionsJsonList, SuggestionX.fromJson),
          agendas: ModelUtilX.generateItems(agendasJsonList, AgendaX.fromJson),
        ),
        requiredDataKeys: [NameX.id, NameX.title],
      );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.title: title,
      NameX.shortDescription: description,
      NameX.statusName: statusName.name,
      NameX.date: date.toIso8601String(),
      NameX.startAt: startAt.toString(),
      NameX.endAt: endAt.toString(),
      NameX.type: type.toJson(),
      NameX.typeId: typeId,
      NameX.number: numberMeetingByType,
      NameX.place: place.name,
      NameX.link: locationOnlineUrl,
      NameX.locale: locationLocale,
      NameX.isClosed: isClosed,
      NameX.isDraft: isDraft,
      NameX.closeRecord: isCloseRecord,
      NameX.enableSuggestion: isSuggestion,
      NameX.publishingAt: publishingAt?.toIso8601String(),
      NameX.createdAt: createdAt?.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
      NameX.deletedAt: deletedAt?.toIso8601String(),
      NameX.googleCalendarEventId: googleCalendarEventId,
      NameX.creator: creatorId,
      NameX.createdBy: created?.toJson(),
      NameX.adminId: adminId,
      NameX.admin: admin?.toJson(),
      NameX.enableVote: isVote,
      NameX.voteAt: voteStartAt?.toIso8601String(),
      NameX.voteEndAt: voteEndAt?.toIso8601String(),
      NameX.repetitionType: repetitionType.name,
      NameX.repetition: repetition.toJson(),
      NameX.repeatDuration: repeatDuration,
      NameX.attendancesCount: attendancesCount,
      NameX.delegatesCount: delegatesCount,
      NameX.questionsCount: questionsCount,
      NameX.rate: rate?.toJson(),
      NameX.tasks: tasks.map((e) => e.toJson()).toList(),
      NameX.visitors: visitors.map((e) => e.toJson()).toList(),
      NameX.roles: roles.map((e) => e.toJson()).toList(),
      NameX.attendances: attendances.map((e) => e.toJson()).toList(),
      NameX.attachments: attachments.map((e) => e.toJson()).toList(),
      NameX.questions: questions.map((e) => e.toJson()).toList(),
      NameX.suggestions: suggestions.map((e) => e.toJson()).toList(),
      NameX.agendas: agendas.map((e) => e.toJson()).toList(),
    };
  }
}