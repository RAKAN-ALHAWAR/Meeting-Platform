import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/Translation/translation.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/Data/Model/dashboard/statistics.dart';

import '../../../../../Config/config.dart';
import '../../../../../Data/data.dart';
import '../../../../ScreenSheet/Language/languageSheet.dart';
import '../../../../Widget/widget.dart';

class ProfileDetailsController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  late StatisticsX statistics;
  bool isInit=false;
  RxString languageName = TranslationX.getCurrentNameLanguage().obs;
  final ScrollController scrollController = ScrollController();
  double scrollPosition = 0.0;

  //============================================================================
  // Functions

  Future getData() async {
    if(!isInit) {
      statistics = await DatabaseX.getStatistics();
      isInit=true;
    }
  }

  onEditProfile() => Get.toNamed(RouteNameX.editProfile);
  onChangePassword() => Get.toNamed(RouteNameX.changePassword);
  onAutomaticAttendances() => Get.toNamed(RouteNameX.automaticAttendances);
  onMySignatures() => Get.toNamed(RouteNameX.signatures);
  onMySuggestions() => Get.toNamed(RouteNameX.mySuggestions);
  onNotificationsSettings() => Get.toNamed(RouteNameX.notificationsSettings);
  onApplicationLanguage() {
    languageSheetX(
      (String val) async {
        try {
          scrollPosition = scrollController.position.pixels;
          /// Switch language
          await TranslationX.changeLocale(val);
          languageName.value=TranslationX.getCurrentNameLanguage();

          /// Save the language to internal storage
          LocalDataX.put(LocalKeyX.language, val);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollPosition);
          });

          /// Close the bottom sheet
          Get.back();
        } catch (e) {
          ToastX.error(message: e.toString());
        }
      },
    );
  }
}
