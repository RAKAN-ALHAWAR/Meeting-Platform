import 'package:get/get.dart';
import '../../../../Core/Service/firebaseRemoteConfigService.dart';
import '../../../../Core/core.dart';
import '../../../ScreenSheet/Signature/AddSignature/view/addSignatureSheet.dart';
import '../../../ScreenSheet/Signature/DeleteSignature/view/deleteSignatureSheet.dart';

class SignaturesController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

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

  onAddSignature() async {
    await addSignatureSheetX();
    signature.value = getUrl(app.user.value.signatureImageUrl);
  }

  onDeleteSignature() async {
    await deleteSignatureSheetX();
    signature.value = getUrl(app.user.value.signatureImageUrl);
  }
}
