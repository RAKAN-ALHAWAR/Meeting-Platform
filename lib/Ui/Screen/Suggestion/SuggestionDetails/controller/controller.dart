import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Data/Model/attachment/attachment.dart';
import 'package:meeting/Data/Model/suggestion/suggestion.dart';
import 'package:meeting/Data/data.dart';

import '../../../../../Config/Translation/translation.dart';
import '../../../../../Core/Service/firebaseRemoteConfigService.dart';

class SuggestionDetailsController extends GetxController {
  //============================================================================
  // Variables

  SuggestionX suggestion = Get.arguments;

  //============================================================================
  // Functions

  Future<SuggestionX> getData() async {
    return await DatabaseX.getSuggestionDetails(id: suggestion.id);
  }

  onTapAttachment(AttachmentX attachment) {
    Get.toNamed(RouteNameX.fileReader, arguments: attachment);
  }

  String getUrl(AttachmentX attachment) {
    if (attachment.path.isURL) {
      return attachment.path;
    } else {
      var url = FirebaseRemoteConfigServiceX.getString('base_url');
      int endIndex = url.indexOf('.com');
      if (endIndex != -1) {
        return '${url.substring(0, endIndex + 4)}/${attachment.path}';
      } else {
        return '$url/${attachment.path}'.trim();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting(TranslationX.getLanguageCode, null);
  }
}
