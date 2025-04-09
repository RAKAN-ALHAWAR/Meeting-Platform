import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meeting/Data/Model/delegate/delegate.dart';
import 'package:meeting/UI/Widget/widget.dart';
import 'package:meeting/Ui/ScreenSheet/Delegate/AcceptDelegate/view/acceptDelegateSheet.dart';

import '../../../../../Config/Translation/translation.dart';
import '../../../../../Data/data.dart';
import '../../../../ScreenSheet/Delegate/RejectDelegate/view/rejectDelegateSheet.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';

class AllDelegatesController extends GetxController {
  //============================================================================
  // Variables

  RxBool isToMe = true.obs;
  final type = ValueNotifier(1);
  GlobalKey<ScrollRefreshLoadMoreXState> scrollRefreshLoadMoreKey =
      GlobalKey<ScrollRefreshLoadMoreXState>();

  //============================================================================
  // Functions

  Future<List<DelegateX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    if (isToMe.value) {
      return await DatabaseX.getAllDelegates(
        page: data.page,
        perPage: data.perPage,
      );
    } else {
      return await DatabaseX.getAllMyDelegates(
        page: data.page,
        perPage: data.perPage,
      );
    }
  }

  onAccept(DelegateX delegate) async {
    try {
      final result = await acceptDelegateSheetX(id: delegate.id);
      if (result == true) {
        scrollRefreshLoadMoreKey.currentState?.resetData();
      }
    } catch (e) {
      ToastX.error(message: e);
    }
  }

  onReject(DelegateX delegate) async {
    try {
      var result = await rejectDelegateSheetX(id: delegate.id);
      if (result == true) {
        scrollRefreshLoadMoreKey.currentState?.resetData();
      }
    } catch (e) {
      ToastX.error(message: e);
    }
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();
    type.addListener(() {
      isToMe.value = type.value == 1;
      scrollRefreshLoadMoreKey.currentState?.refresh();
      update();
    });
    initializeDateFormatting(TranslationX.getLanguageCode, null);
  }
}
