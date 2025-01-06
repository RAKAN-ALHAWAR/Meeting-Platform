part of '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Managing the day and night theme for the entire application
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ThemeX {
  //============================================================================
  // Functions
  static ThemeMode get getTheme => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  static bool get isDarkMode => LocalDataX.themeIsDark;

  static change(bool val) => Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);

  //============================================================================
  // Data

  /// Light Theme
  static ThemeData light = ThemeData.light().copyWith(
    /// Fonts
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: FontX.fontFamily,
          bodyColor: ColorX.grey.shade900,
          decorationColor: ColorX.grey.shade900,
          displayColor: ColorX.grey.shade900,
        ),

    /// Text
    hintColor: ColorX.grey.shade400,

    /// Primary Color
    // Primary color for major parts of the app (toolbars, tab bars, etc.)
    primaryColor: ColorX.primary,
    // Darker variant of the primary color
    primaryColorDark: ColorX.primary.shade900,
    // Lighter variant of the primary color
    primaryColorLight: ColorX.primary.shade300,

    /// Background Color
    canvasColor: Colors.white,
    // Background color for larger parts of the app
    scaffoldBackgroundColor: ColorX.backgroundLight,

    /// Widgets
    cardColor: Colors.white,
    dividerColor: ColorX.grey.shade100,
    unselectedWidgetColor: ColorX.grey.shade700,
    disabledColor: ColorX.grey.shade200,

    /// Effect Color
    highlightColor: ColorX.primary.shade50,
    // The color of the circle that selects the clicked item
    splashColor: ColorX.primary.shade50,
    // The color of the flashing effect when you click on an item

    colorScheme: ColorScheme.fromSeed(
        // Determines if the theme is light or dark
        brightness: Brightness.light,
        primary: ColorX.primary,
        onPrimary: ColorX.primary.shade50,
        seedColor: ColorX.primary,
        secondary: ColorX.grey.shade500,
        onSecondary: ColorX.grey.shade50,
        error: ColorX.danger,
        onError: ColorX.danger.shade50,
        outline: ColorX.grey.shade200,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    ),
    cardTheme: CardTheme(color: ColorX.grey.shade50),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorX.primary,
      unselectedIconTheme: IconThemeData(color: ColorX.grey.shade400),
      backgroundColor: Colors.white,
      unselectedItemColor: ColorX.grey.shade500,
      unselectedLabelStyle: TextStyle(
        fontSize: 13.1,
        color: ColorX.grey.shade500,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ColorX.backgroundLight,
    ),
  );

  //=============================================================

  static ThemeData dark = ThemeData.dark().copyWith(
    /// Fonts
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: FontX.fontFamily),

    /// Text
    hintColor: ColorX.grey.shade500,

    /// Primary Color
    // Primary color for major parts of the app (toolbars, tab bars, etc.)
    primaryColor: ColorX.primary.shade400,
    // Darker variant of the primary color
    primaryColorDark: ColorX.primary.shade900,
    // Lighter variant of the primary color
    primaryColorLight: ColorX.primary.shade300,

    /// Background Color
    canvasColor: ColorX.grey.shade900,
    // Background color for larger parts of the app
    scaffoldBackgroundColor: ColorX.backgroundDark,

    /// Widgets
    cardColor: ColorX.grey.shade800,
    dividerColor: ColorX.grey.shade700,
    unselectedWidgetColor: ColorX.grey.shade500,
    disabledColor: ColorX.grey.shade600,

    /// Effect Color
    highlightColor: ColorX.primary.shade900.withOpacity(0.5),
    // The color of the circle that selects the clicked item
    splashColor: ColorX.primary.shade900.withOpacity(0.6),
    // The color of the flashing effect when you click on an item

    colorScheme: ColorScheme.fromSeed(
      // Determines if the theme is light or dark
      brightness: Brightness.dark,
      primary: ColorX.primary,
      onPrimary: ColorX.primary.shade200,
      seedColor: ColorX.primary,
      secondary: ColorX.grey.shade300,
      onSecondary: ColorX.grey.shade700,
      error: ColorX.danger.shade500,
      onError: ColorX.danger.shade300,
    ),
    cardTheme: CardTheme(color: ColorX.grey.shade700),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorX.grey.shade600,
      shadowColor: Colors.transparent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorX.grey.shade900,
      surfaceTintColor: ColorX.grey.shade900,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorX.primary.shade600,
      unselectedItemColor: ColorX.grey.shade500,
      backgroundColor: ColorX.grey.shade800,
      unselectedLabelStyle: TextStyle(
        fontSize: 13.1,
        color: ColorX.grey.shade800,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ColorX.backgroundDark,
    ),
  );
}
