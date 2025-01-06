import 'package:get/get.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Constant/navbarItems.dart';
import '../../../../Data/Model/basic/root_page.dart';

class RootController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxInt indexPageSelected = 0.obs;
  late List<RootPageX> pages = navBarItems;
  RxBool isMoreDynamicPage = false.obs;

  //============================================================================
  // Functions

  isHomePage() => indexPageSelected.value == 0;

  onItemSelected(int index) {
      indexPageSelected.value = index;
  }

  openHome() => onItemSelected(0);

}
