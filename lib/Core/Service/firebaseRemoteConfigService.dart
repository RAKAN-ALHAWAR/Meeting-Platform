import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigServiceX {
  static final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  /// Singleton instance to ensure only one instance of RemoteConfigService is used.
  static Future<void> init() async {
    // Fetch and activate the latest values from Firebase
    await fetchAndActivateConfig();
  }

  /// Fetches and activates the Remote Config values.
  static Future<void> fetchAndActivateConfig() async {
    try {
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }

  /// Get the value of a specific key (e.g., 'main_api_url')
  static String getString(String key,[String? def]) {
    var x = remoteConfig.getString(key);
    return x.isNotEmpty?x:def??'';
  }
}