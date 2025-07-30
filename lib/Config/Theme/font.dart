part of '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Manage the fonts used in the application
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class FontX {
  //============================================================================
  // Data

  /// Font Family Names
  static const ar = 'IBMPlexSansArabic';
  static const en = 'IBMPlexSansArabic';

  //============================================================================
  // Functions

  /// Fetch font by language
  static String get fontFamily {
    switch (TranslationX.getLanguageCode) {
      case 'ar':
        return ar;
      case 'en':
        return en;
      default:
        return en;
    }
  }
}
