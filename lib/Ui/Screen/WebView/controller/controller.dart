import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewController extends GetxController {
  //============================================================================
  // Variables

  String url = Get.arguments??'';
  Map<String, String> meetingPlatforms = {
    'zoom.us': 'Zoom',
    'teams.microsoft.com': 'Microsoft Teams',
    'meet.google.com': 'Google Meet',
    'webex.com': 'Cisco Webex',
    'gotomeeting.com': 'GoToMeeting',
    'bluejeans.com': 'BlueJeans',
    'join.me': 'Join.Me',
    'skype.com': 'Skype',
    'whereby.com': 'Whereby',
    'uberconference.com': 'UberConference',
    'bigbluebutton.org': 'BigBlueButton',
  };
  RxBool isUrlValid = true.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingWeb = true.obs;
  RxInt progress = 0.obs;
  Rx<String?> errorMessage = Rx<String?>(null);
  String appBarTitle = 'Online Meeting';
  late WebViewController webViewController;

  //============================================================================
  // Functions

  Future<void> _initializeWebView() async {
    isUrlValid.value = false;
    if (_isValidUrl(url)) {
      isUrlValid.value = true;
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              _updateAppBarTitle(url);
               _handleUrl(url);
              isLoading.value=false;
              isLoadingWeb.value = true;
                errorMessage.value = null;
            },
            onProgress: (progress) {
                this.progress.value = progress;
                if(progress==100) {
                  isLoadingWeb.value = false;
                }
            },
            onPageFinished: (String url) {
              isLoadingWeb.value = false;
            },
            onWebResourceError: (WebResourceError error) {
              isLoadingWeb.value = false;
                errorMessage.value = """⚠️ حدث خطأ أثناء تحميل الصفحة ⚠️ \n--------------------------------\n ${error.errorCode}\n${error.description}\nURL: ${error.url ?? "غير متوفر"}\n""";
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    } else {
      isUrlValid.value = false;
      isLoading.value= false;
    }
  }

  Future<void> _handleUrl(String url) async {
    if (await _isMeetingPlatformUrl(url) &&
        await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      Get.back();
    }
  }

  Future<bool> _isMeetingPlatformUrl(String url) async {
    Uri uri = Uri.parse(url);
    return meetingPlatforms.keys.any((domain) => uri.host.contains(domain));
  }

  void _updateAppBarTitle(String url) {
    Uri uri = Uri.parse(url);
    String platformName = meetingPlatforms.entries
        .firstWhere((entry) => uri.host.contains(entry.key),
            orElse: () => const MapEntry('', 'Online Meeting'))
        .value;

    appBarTitle = platformName;
    update();
  }

  bool _isValidUrl(String url) {
    try {
      Uri uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (_) {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeWebView();
  }
}
