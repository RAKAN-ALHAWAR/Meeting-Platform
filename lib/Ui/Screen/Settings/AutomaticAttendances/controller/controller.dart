import 'package:get/get.dart';
import 'package:meeting/Data/data.dart';
import 'package:meeting/UI/Widget/widget.dart';

import '../../../../../Core/core.dart';

class AutomaticAttendancesController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  late RxBool automaticPreparation = (app.user.value.automaticAttendances??false).obs;

  //============================================================================
  // Functions

  onChangeAutomaticPreparation()async{
    try{
      automaticPreparation.value=!automaticPreparation.value;
      await DatabaseX.updateAutomaticAttendances(active: automaticPreparation.value);
      app.user.value.automaticAttendances=automaticPreparation.value;
    }catch(e){
      automaticPreparation.value=!automaticPreparation.value;
      ToastX.error(message: e);
    }
  }
}