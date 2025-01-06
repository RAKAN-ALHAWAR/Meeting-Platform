part of '../../data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Default data if no stored data is available
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class LocalDefaultDataX {
  static String route = RouteNameX.login;
  static String token = '';
  static bool themeIsDark = false;
  // static bool themeIsDark = Get.isPlatformDarkMode;
  // static String language = 'ar';
  static String language = Get.deviceLocale?.languageCode ??
      TranslationX.fallbackLocale.languageCode;
}
