import 'package:get/get.dart';
import '../../../../../Core/Service/firebaseRemoteConfigService.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class ShowMinutesSignatureSheetController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isDeleteLoading = false.obs;
  late Rx<String?> signature = getUrl(app.user.value.signatureImageUrl).obs;

  //============================================================================
  // Functions

  String? getUrl(String? signature) {
    if (signature == null) {
      return null;
    } else {
      if (signature.isURL) {
        return signature;
      } else {
        var url = FirebaseRemoteConfigServiceX.getString('base_url');
        int endIndex = url.indexOf('.com');
        if (endIndex != -1) {
          return '${url.substring(0, endIndex + 4)}/$signature';
        } else {
          return '$url/$signature'.trim();
        }
      }
    }
  }

  //============================================================================
  // Functions

  onDeleteSignature() async {
    try {
      if (isDeleteLoading.isFalse) {
        isDeleteLoading.value = true;
        var message = await DatabaseX.deleteAllSignature();
        app.user.value.signatureImageUrl = null;

        Get.back(result: false);
        if (message != null) {
          ToastX.success(message: message);
        }
      }
    } catch (e) {
      ToastX.error(message: e.toString());
    }
    isDeleteLoading.value = false;
  }

  onApprove() async {
    Get.back(result: true);
  }
}
