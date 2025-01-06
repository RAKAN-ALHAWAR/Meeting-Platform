import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewController extends GetxController {
  //============================================================================
  // Variables

  String url = Get.arguments ?? '';
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
  String appBarTitle= 'Online Meeting';
  late WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          _handleUrl(url);
        },
        onPageFinished: (String url) {
          _updateAppBarTitle(url);
        },
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(url));

  //============================================================================
  // Functions

  Future<void> _handleUrl(String url) async {
    if (await _isMeetingPlatformUrl(url) && await canLaunchUrl(Uri.parse(url))) {
      // If the link is to a supported platform and the app is present
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
        .firstWhere(
          (entry) => uri.host.contains(entry.key),
      orElse: () => const MapEntry('', 'Online Meeting'),
    )
        .value;

    appBarTitle = platformName;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _updateAppBarTitle(url);
  }

}