import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Config/Route/route_list.dart';
import 'Config/Translation/translation.dart';
import 'Config/config.dart';
import 'Core/Logging/logging.dart';
import 'Core/Service/firebaseRemoteConfigService.dart';
import 'Core/core.dart';
import 'Data/data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// The project's starting point: everything is initialized here before the
/// project starts running.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void main() async {
  await LoggingX.safeZone(() async {
    // Ensures that the Flutter framework is properly initialized
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await FirebaseRemoteConfigServiceX.init();

    await LoggingX.init(
      addToFlutterError: [FirebaseCrashlytics.instance.recordFlutterFatalError],
      addToPlatformDispatcher: [
        (Object error, StackTrace stack) =>
            FirebaseCrashlytics.instance.recordError(error, stack, fatal: true)
      ],
    );

    await ConfigX.init();
    await DataX.init();
    await CoreX.init();

    // Start the Flutter application
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /// Remove mark debug
      debugShowCheckedModeBanner: false,

      /// Initialization of the main controllers
      initialBinding: BindingsBuilder(() {
        Get.put(
          AppControllerX(),
          permanent: true,
        );
      }),

      /// Routes
      getPages: RouteListX.routes,
      initialRoute: RouteNameX.loading,
      // ربط Firebase Analytics مع Navigation Observer
      navigatorObservers: <NavigatorObserver>[observer],

      /// Settings GetX
      smartManagement: SmartManagement.full,
      useInheritedMediaQuery: true,

      /// App name with translate
      title: 'Meeting Platform'.tr,

      /// Translate App
      translations: TranslationX(),
      locale: TranslationX.getLocale,
      fallbackLocale: TranslationX.fallbackLocale,

      /// Themes
      themeMode: ThemeX.getTheme,
      theme: ThemeX.light,
      darkTheme: ThemeX.dark,
    );
  }
}
