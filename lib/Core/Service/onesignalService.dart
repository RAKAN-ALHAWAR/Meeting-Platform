import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnesignalServiceX {
  static const appId = 'd573e9ce-c683-412c-a2e8-75d8caea5f0e';

  static Future<void> init() async {
  // Enable verbose logging for debugging (remove in production)
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // Initialize with your OneSignal App ID
  OneSignal.initialize(appId);
  // Use this method to prompt for push notifications.
  // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
  OneSignal.Notifications.requestPermission(false);
  }
}
