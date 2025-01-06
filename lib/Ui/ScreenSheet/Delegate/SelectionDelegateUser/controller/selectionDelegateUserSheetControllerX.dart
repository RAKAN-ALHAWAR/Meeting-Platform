import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Data/Model/user/mini_user.dart';

class SelectionDelegateUserSheetControllerX extends GetxController {
  //============================================================================
  // Variables

  List<MiniUserX> users = [];
  RxList<MiniUserX> results = <MiniUserX>[].obs;
  Rx<MiniUserX?> delegateSelected = Rx<MiniUserX?>(null);
  TextEditingController search = TextEditingController();

  //============================================================================
  // Functions
  /// Erase all data and return it to its default state
  clearData() {
    delegateSelected.value = null;
    search.text = "";
  }

  onSave(){
    Get.back(result: delegateSelected.value);
  }
  onSearching(String val) {
    results.value = users.where((x) => x.name.contains(val)).toList();
  }

  onChange(MiniUserX? val) {
    delegateSelected.value = val;
  }
}
