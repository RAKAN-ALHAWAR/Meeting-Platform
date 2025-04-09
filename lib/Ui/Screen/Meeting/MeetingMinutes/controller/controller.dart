import 'dart:async';
import 'dart:io';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:meeting/Config/Translation/translation.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/Data/Model/meeting/meeting.dart';
import 'package:meeting/Ui/ScreenSheet/Signature/ShowMinutesSignature/view/showMinutesSignatureSheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

import '../../../../../Config/config.dart';
import '../../../../../Core/Service/firebaseRemoteConfigService.dart';
import '../../../../../Data/Model/attendance/attendance.dart';
import '../../../../../Data/data.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../ScreenSheet/Signature/AddSignature/view/addSignatureSheet.dart';
import '../../../../ScreenSheet/Signature/MinutesSignatureSuccess/minutesSignatureSuccessSheet.dart';
import '../../../../Widget/Basic/Utils/future_builder.dart';
import '../../../../Widget/widget.dart';

class MeetingMinutesController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  /// Get Meeting Id
  String id = Get.arguments.toString();
  RxBool isLoading = false.obs;
  late Rx<MeetingX> meeting;
  late Rx<File> file;
  Rx<AttendanceX?> myAttendance = Rx(null);
  RxList<AttendanceX> attendances = <AttendanceX>[].obs;
  RxList<String> recommendations = <String>[].obs;
  RxList<String> permissions = <String>[].obs;

  Rx<ButtonStateEX> buttonStateSignature = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> buttonStateDownloadMinutes = ButtonStateEX.normal.obs;
  Map<String, dynamic> signaturesImages = {};
  late Uint8List logoWhite;
  late pw.Font fontBold;
  late pw.Font fontRegular;
  late pw.Font fontLight;

  GlobalKey<FutureBuilderXState> futureBuilderKey =
      GlobalKey<FutureBuilderXState>();
  //============================================================================
  // Functions

  Future getData() async {
    /// Get Meeting & Attendance & Permissions Data
    var result = await DatabaseX.getMeetingDetails(id: id);
    meeting = result.$1.obs;
    myAttendance.value = result.$2;

    permissions = result.$3.obs;
    attendances.value = meeting.value.attendances;
    if(myAttendance.value==null){
      myAttendance.value = attendances.firstWhereOrNull((e)=>e.userId==app.user.value.id);
    }
    for (var x in meeting.value.attendances
        .where((element) => element.signature != null)) {
      signaturesImages[x.id] = await networkImage(getUrl(x.signature!)!);
    }
    recommendations.value = meeting.value.agendas
        .where((val) => val.recommendContent != null)
        .map((e) => e.recommendContent!)
        .toList();

    var x = await rootBundle.load(ImageX.logoWhite);
    logoWhite = x.buffer.asUint8List();
    final fontDataBold =
        await rootBundle.load('assets/fonts/IBMPlexSansArabic-SemiBold.ttf');
    fontBold = pw.Font.ttf(fontDataBold);
    final fontDataRegular =
        await rootBundle.load('assets/fonts/IBMPlexSansArabic-Regular.ttf');
    fontRegular = pw.Font.ttf(fontDataRegular);
    final fontDataLight =
        await rootBundle.load('assets/fonts/IBMPlexSansArabic-Light.ttf');
    fontLight = pw.Font.ttf(fontDataLight);
    await generateAndSavePdf();
  }

  String? getUrl(String? signature) {
    if (signature == null) {
      return null;
    } else {
      if (signature.isURL) {
        return signature;
      } else {
        var url = FirebaseRemoteConfigServiceX.getString('base_url');
        RegExp regExp = RegExp(r'\.(com|sa)');
        Match? match = regExp.firstMatch(url);
        int endIndex = match != null ? match.start : -1;
        if (endIndex != -1) {
          return '${url.substring(0, endIndex + 4)}/$signature';
        } else {
          return '$url/$signature'.trim();
        }
      }
    }
  }

  onSignature() async {
    if (isLoading.isFalse) {
      isLoading.value = true;
      buttonStateSignature.value = ButtonStateEX.loading;
      try {
        dynamic x;
        if (app.user.value.signatureImageUrl == null) {
          x = await addSignatureSheetX(isMinutes: true);
        } else {
          x = await showMinutesSignatureSheetX();
          if (x == false) {
            x = await addSignatureSheetX(isMinutes: true);
          }
        }
        if (x == true) {
          await DatabaseX.addSignatureMeetingMinutes(id);
          await minutesSignatureSuccessSheetX();
          futureBuilderKey.currentState?.onRefresh();
        }

        /// The time delay here is aesthetically beneficial
        buttonStateSignature.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
        );
      } catch (e) {
        buttonStateSignature.value = ButtonStateEX.failed;
        ToastX.error(message: e.toString());
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
        () {
          buttonStateSignature.value = ButtonStateEX.normal;
        },
      );
    }
  }

  onDownloadMinutes() async {
    if (isLoading.isFalse) {
      try {
        isLoading.value = true;
        buttonStateDownloadMinutes.value = ButtonStateEX.loading;

        var status = await Permission.storage.status;

        if (!status.isGranted) {
          await Permission.storage.request();
        }

        status = await Permission.storage.status;
        if (!status.isGranted) {
          if (await Permission.storage.isPermanentlyDenied) {
            ToastX.error(
              message:
                  'Permission to access storage is permanently denied. Please enable it from settings.',
            );
            await openAppSettings();
            return;
          }
        }
        Directory downloadDirectory = await getDownloadDirectory();

        String basePath =
            '${downloadDirectory.path}/${meeting.value.title} - meeting minutes';
        String path = '$basePath.pdf';

        int counter = 1;
        while (await File(path).exists()) {
          path = '$basePath ($counter).pdf';
          counter++;
        }

        // save file
        await file.value.copy(File(path).path);

        ToastX.success(
          message: 'The minutes have been downloaded to your device',
        );

        /// The time delay here is aesthetically beneficial
        buttonStateDownloadMinutes.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
        );
      } catch (e) {
        buttonStateDownloadMinutes.value = ButtonStateEX.failed;
        ToastX.error(message: e.toString());
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
        () {
          buttonStateDownloadMinutes.value = ButtonStateEX.normal;
        },
      );
    }
  }

  Future<void> generateAndSavePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        header: (context) => _topCorner(),
        footer: (context) => _footer(context.pageNumber),
        textDirection:
            DeviseX.isLTR ? pw.TextDirection.ltr : pw.TextDirection.rtl,
        build: (context) {
          return [
            _header(),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 25),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _divider(),
                  _title('Names of attendees'),
                  pw.SizedBox(height: 10),
                  _tableHeader(),
                  pw.SizedBox(height: 6),
                  for (var x in meeting.value.attendances)
                    _tableRow(x.status.name, x.user?.name ?? '',
                        x.user?.jobTitle, signaturesImages[x.id]),
                  _tableFooter(meeting.value.admin?.name ?? '',
                      meeting.value.created?.name ?? ''),
                  pw.SizedBox(height: 14),
                  _title('Meeting agenda'),
                  for (var x in meeting.value.agendas)
                    _dottedCountText(x.content),
                  pw.SizedBox(height: 14),
                  _title('Recommendations'),
                  if (recommendations.isEmpty)
                    pw.Text(
                      'There are no recommendations from this meeting.'.tr,
                      style: pw.TextStyle(
                        font: fontRegular,
                        fontSize: 11,
                        letterSpacing: 0.15,
                        color: PdfColor.fromInt(ColorX.grey.shade600.value),
                      ),
                    ),
                  if (recommendations.isNotEmpty)
                    for (var x in recommendations) _dottedCountText(x),
                ],
              ),
            ),
          ];
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final x = File("${directory.path}/meeting_minutes.pdf");
    await x.writeAsBytes(await pdf.save());
    file = x.obs;
  }

  bool isArabic(String? text) {
    if (text == null) {
      return !DeviseX.isLTR;
    } else {
      final arabicRegExp = RegExp(r'[\u0600-\u06FF]');
      return arabicRegExp.hasMatch(text);
    }
  }

  getDirection(String? text) =>
      isArabic(text) ? pw.TextDirection.rtl : pw.TextDirection.ltr;
  getAlign(String? text) => isArabic(text)
      ? (DeviseX.isLTR ? pw.TextAlign.end : pw.TextAlign.start)
      : (DeviseX.isLTR ? pw.TextAlign.start : pw.TextAlign.end);

  _tableHeader() {
    return pw.Container(
      height: 46,
      width: double.maxFinite,
      padding: const pw.EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(ColorX.grey.shade100.value),
        borderRadius: pw.BorderRadius.circular(9),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              'Attendance status'.tr,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 12,
                letterSpacing: 0.15,
                color: PdfColor.fromInt(ColorX.grey.shade900.value),
              ),
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              'Name'.tr,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 12,
                letterSpacing: 0.15,
                color: PdfColor.fromInt(ColorX.grey.shade900.value),
              ),
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              'Job title'.tr,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 12,
                letterSpacing: 0.15,
                color: PdfColor.fromInt(ColorX.grey.shade900.value),
              ),
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              'The Signature'.tr,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 12,
                letterSpacing: 0.15,
                color: PdfColor.fromInt(ColorX.grey.shade900.value),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _tableFooter(String? sessionChair, String? meetingOrganizer) {
    return pw.Container(
      height: 46,
      width: double.maxFinite,
      margin: const pw.EdgeInsets.only(top: 6),
      padding: const pw.EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          width: 1,
          color: PdfColor.fromInt(ColorX.grey.shade200.value),
        ),
        borderRadius: pw.BorderRadius.circular(9),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Row(children: [
              pw.Text(
                '${'Session Chair'.tr}: ',
                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 12,
                  letterSpacing: 0.15,
                  color: PdfColor.fromInt(ColorX.grey.shade500.value),
                ),
              ),
              pw.Text(
                sessionChair ?? '',
                textDirection: getDirection(sessionChair),
                textAlign: getAlign(sessionChair),
                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 12,
                  letterSpacing: 0.15,
                  color: PdfColor.fromInt(ColorX.grey.shade700.value),
                ),
              ),
            ]),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              horizontal: 26,
            ),
            child: pw.VerticalDivider(
              color: PdfColor.fromInt(ColorX.grey.shade200.value),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Row(children: [
              pw.Text(
                '${'Meeting Organizer'.tr}: ',
                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 12,
                  letterSpacing: 0.15,
                  color: PdfColor.fromInt(ColorX.grey.shade500.value),
                ),
              ),
              pw.Text(
                meetingOrganizer ?? '',
                textDirection: getDirection(meetingOrganizer),
                textAlign: getAlign(meetingOrganizer),
                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 12,
                  letterSpacing: 0.15,
                  color: PdfColor.fromInt(ColorX.grey.shade700.value),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  _tableRow(String state, String name, String? jobTitle, dynamic signature) {
    return pw.Container(
      height: 46,
      width: double.maxFinite,
      padding: const pw.EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              state.tr,
              style: pw.TextStyle(
                font: fontRegular,
                fontSize: 12,
                letterSpacing: 0.15,
                color: PdfColor.fromInt(ColorX.grey.shade700.value),
              ),
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              name,
              textDirection: getDirection(name),
              textAlign: getAlign(name),
              style: pw.TextStyle(
                font: fontRegular,
                fontSize: 12,
                letterSpacing: 0.15,
                color: PdfColor.fromInt(ColorX.grey.shade700.value),
              ),
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              jobTitle ?? '',
              textDirection: getDirection(jobTitle),
              textAlign: getAlign(jobTitle),
              style: pw.TextStyle(
                font: fontRegular,
                fontSize: 12,
                letterSpacing: 0.15,
                color: PdfColor.fromInt(ColorX.grey.shade700.value),
              ),
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            flex: 2,
            child: signature != null ? pw.Image(signature) : pw.SizedBox(),
          ),
        ],
      ),
    );
  }

  _divider() {
    return pw.Divider(
      color: PdfColor.fromInt(ColorX.grey.shade200.value),
    );
  }

  _dottedCountText(String text) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
          width: 4,
          height: 4,
          decoration: pw.BoxDecoration(
            color: PdfColor.fromInt(Colors.black.value),
            borderRadius: pw.BorderRadius.circular(2),
          ),
        ),
        pw.SizedBox(width: 8),
        pw.Text(
          text,
          textDirection: getDirection(text),
          textAlign: getAlign(text),
          style: pw.TextStyle(
            font: fontRegular,
            fontSize: 11,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade900.value),
          ),
        ),
      ],
    );
  }

  _title(String title) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 10),
        pw.Text(
          title.tr,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: fontBold,
            fontSize: 14,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade900.value),
          ),
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  _topCorner() {
    return pw.Container(
      height: 70,
      width: double.maxFinite,
      color: PdfColor.fromInt(ColorX.primary.shade600.value),
      padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Image(pw.MemoryImage(logoWhite), height: 40),
          pw.Text(
            'Meeting Minutes'.tr,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              font: fontBold,
              letterSpacing: 0.15,
              fontSize: 16,
              color: PdfColor.fromInt(Colors.white.value),
            ),
          ),
        ],
      ),
    );
  }

  _header() {
    return pw.SizedBox(
      child: pw.Column(
        children: [
          pw.Text(
            meeting.value.title,
            textDirection: getDirection(meeting.value.title),
            textAlign: getAlign(meeting.value.title),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              font: fontBold,
              fontSize: 16,
              letterSpacing: 0.15,
              color: PdfColor.fromInt(ColorX.grey.shade900.value),
            ),
          ),
          pw.SizedBox(height: 8),
          _numberAndPlaceOfMeeting(),
          pw.SizedBox(height: 8),
          _dateOfMeeting(),
          pw.SizedBox(height: 10),
        ],
      ),
    );
  }

  _numberAndPlaceOfMeeting() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(
          '${'Meeting number'.tr}: ',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: fontLight,
            fontSize: 10,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade700.value),
          ),
        ),
        pw.Text(
          meeting.value.numberMeetingByType.toString(),
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: fontRegular,
            fontSize: 10,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade800.value),
          ),
        ),
        pw.SizedBox(width: 16),
        pw.Text(
          '${'Meeting location'.tr}: ',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: fontLight,
            fontSize: 10,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade700.value),
          ),
        ),
        pw.Text(
          meeting.value.place.name.tr,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: fontRegular,
            fontSize: 10,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade800.value),
          ),
        ),
      ],
    );
  }

  _dateOfMeeting() {
    final dateFormatter =
        intl.DateFormat('yyyy/MM/dd, EEEE', TranslationX.getLanguageCode);
    final timeFormatter = intl.DateFormat('HH:mm');

    final formattedDate = dateFormatter.format(meeting.value.date);
    final formattedStartTime =
        timeFormatter.format(meeting.value.startFullDate);
    final formattedEndTime = timeFormatter.format(meeting.value.endFullDate);

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(
          '${'Meeting date'.tr}: ',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: fontLight,
            fontSize: 10,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade700.value),
          ),
        ),
        pw.Text(
          '$formattedDate $formattedStartTime ${'to'.tr} $formattedEndTime',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: fontRegular,
            fontSize: 10,
            letterSpacing: 0.15,
            color: PdfColor.fromInt(ColorX.grey.shade800.value),
          ),
        ),
      ],
    );
  }

  pw.Widget _footer(int page) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 25),
      child: pw.Column(
        children: [
          pw.SizedBox(height: 10),
          _divider(),
          pw.SizedBox(height: 4),
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Row(
              children: [
                pw.Expanded(
                    flex: 3,
                    child: pw.Align(
                      alignment: pw.AlignmentDirectional.centerStart,
                      child: pw.Text(
                        'تم انتاج هذا المستند بواسطة ركن الحوار',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: fontRegular,
                          fontSize: 10,
                          letterSpacing: 0.15,
                          color: PdfColor.fromInt(ColorX.grey.shade900.value),
                        ),
                      ),
                    )),
                pw.Expanded(
                  flex: 1,
                  child: pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      page.toString(),
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        font: fontRegular,
                        fontSize: 10,
                        letterSpacing: 0.15,
                        color: PdfColor.fromInt(ColorX.grey.shade900.value),
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Align(
                    alignment: pw.AlignmentDirectional.centerEnd,
                    child: pw.Directionality(
                      textDirection: pw.TextDirection.ltr,
                      child: pw.Text(
                        'This document was produced by edialogue center',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: fontRegular,
                          fontSize: 10,
                          letterSpacing: 0.15,
                          color: PdfColor.fromInt(ColorX.grey.shade900.value),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 18),
        ],
      ),
    );
  }
}
