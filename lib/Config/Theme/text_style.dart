part of '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Manage text style and sizes
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class TextStyleX {

  /// Header
  static TextStyle headerLarge = const TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
    letterSpacing:0.15
  );
  static TextStyle headerMedium = const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w700,
    letterSpacing:0.15
  );
  static TextStyle headerSmall = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    letterSpacing:0.15
  );

  /// Title
  static TextStyle titleLarge = const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    letterSpacing:0.15
  );
  static TextStyle titleMedium = const TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    letterSpacing:0.15
  );
  static TextStyle titleSmall = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing:0.15
  );


  /// SupTitle
  static TextStyle supTitleLarge = TextStyle(
      fontSize: 13.0,
      color: Get.theme.colorScheme.secondary,
      fontWeight: FontWeight.w400,
      letterSpacing:0.15
  );
  static TextStyle supTitleMedium = TextStyle(
      fontSize: 12.2,
      color: Get.theme.colorScheme.secondary,
      fontWeight: FontWeight.w400,
      letterSpacing:0.15
  );
  static TextStyle supTitleSmall = TextStyle(
    fontSize: 10.0,
    color: Get.theme.colorScheme.secondary,
    letterSpacing:0.15
  );

}
