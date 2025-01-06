import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../../Config/Translation/translation.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Model/suggestion/suggestion.dart';
import '../../../../../Data/data.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';

class MySuggestionsController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  GlobalKey<ScrollRefreshLoadMoreXState> scrollRefreshLoadMoreKey =
      GlobalKey<ScrollRefreshLoadMoreXState>();

  //============================================================================
  // Functions

  Future<List<SuggestionX>> getData(
      ScrollRefreshLoadMoreParametersX data) async {
    return await DatabaseX.getAllSuggestions(
      page: data.page,
      perPage: data.perPage,
    );
  }

  onSuggestionDetails(SuggestionX suggestion) =>
      Get.toNamed(RouteNameX.suggestionDetails, arguments: suggestion);

  onAddSuggestion() async {
    var x = await Get.toNamed(RouteNameX.addSuggestion);
    if (x == true) {
      scrollRefreshLoadMoreKey.currentState?.resetData();
    }
  }


  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting(TranslationX.getLanguageCode, null);
  }
}
