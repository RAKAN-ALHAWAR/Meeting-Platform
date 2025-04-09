import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


class MyWebViewController extends GetxController {
  late InAppWebViewController webViewController;
  late final String webUrl = convertToZoomWebClient(Get.arguments??'');
  RxBool isGoogleMeet = false.obs;
  final progress = 0.obs;
  RxBool isLoading = true.obs;
  RxBool isUrlValid = true.obs;
  Rx<String?> errorMessage = Rx(null);

  final Map<String, String> meetingPlatforms = {
    'zoom.us': 'Zoom',
    'teams.microsoft.com': 'Microsoft Teams',
    'meet.google.com': 'Google Meet',
    'gotomeeting.com': 'Go To',
    'skype.com': 'Skype',
  };
  String convertToZoomWebClient(String url) {
    Uri? uri = Uri.tryParse(url);
    if (uri == null) return url;

    if (uri.host.contains("zoom.us") && uri.pathSegments.contains("j")) {
      String meetingId = uri.pathSegments.last;
      String? password = uri.queryParameters["pwd"];

      // إضافة خيارات تفعيل الصوت والفيديو
      return "https://${uri.host}/wc/join/$meetingId${password != null ? '?pwd=$password&unmute=true&startVideo=true' : '?unmute=true&startVideo=true'}";
    }
    return url;
  }
  String getMeetingPlatformName() {
    Uri uri = Uri.parse(webUrl);
    return meetingPlatforms[uri.host] ?? 'Online Meeting';
  }

  void updateLoadingProgress(int progress) {
    this.progress.value = progress;
    if(progress==100){
      isLoading.value=false;
    }
  }
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction navigationAction) async {
    return NavigationActionPolicy.ALLOW;
  }

  Future<void> handleExternalNavigation() async {
    if (webUrl.contains("meet.google.com")) {
       isGoogleMeet.value=true;
        final uri = Uri.parse(webUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
        Get.back();
    }else{
      isGoogleMeet.value=false;
    }
  }
  bool _isValidUrl(String url) {
    try {
      Uri uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (_) {
      return false;
    }
  }
  Future<void> requestPermissions() async {
    await [
      Permission.microphone,
      Permission.camera,
    ].request();
  }
  @override
  void onInit() {
    super.onInit();
    requestPermissions();
    isUrlValid.value = _isValidUrl(webUrl);
  }
}
