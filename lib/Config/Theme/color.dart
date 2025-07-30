part of '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Manage all application colors and color tones
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ColorX {
  /// Primary
  static MaterialColor primary =const MaterialColor(0xff0D7872, {
    50:Color(0xffE1F2F3),//
    100:Color(0xffB3DEDF),
    200:Color(0xff8ac7c9),
    300:Color(0xff50afab),
    400:Color(0xff2BA5A3),
    500:Color(0xff0F9591),//
    600:Color(0xff178782),
    700:Color(0xff0D7872),//
    800:Color(0xff0E7973),
    900:Color(0xff074D49),
  });


  /// Green
  static MaterialColor green =const MaterialColor(0xff0E9F6E, {
    50:Color(0xffF3FAF7),//
    100:Color(0xffDEF7EC),//
    200:Color(0xffBCF0DA),//
    300:Color(0xff84E1BC),//
    400:Color(0xff000000),
    500:Color(0xff0E9F6E),//
    600:Color(0xff057A55),//
    700:Color(0xff000000),
    800:Color(0xff000000),
    900:Color(0xff000000),
  });


  /// Yellow
  static MaterialColor yellow =const MaterialColor(0xffC27803, {
    50:Color(0xffFDFDEA),//
    100:Color(0xff000000),
    200:Color(0xff000000),
    300:Color(0xffFACA15),//
    400:Color(0xffE3A008),//
    500:Color(0xffC27803),//
    600:Color(0xff000000),
    700:Color(0xff000000),
    800:Color(0xff000000),
    900:Color(0xff000000),
  });


  /// Info
  static MaterialColor blue =const MaterialColor(0xff00AAD8, {
    50:Color(0xffEBFDFF),//
    100:Color(0xff000000),
    200:Color(0xffA2EFFF),//
    300:Color(0xff63E1FD),
    400:Color(0xff00AAD8),
    500:Color(0xff0388B7),//
    // 500:Color(0xff00AAD8),//
    600:Color(0xff0388B7),
    700:Color(0xff000000),
    800:Color(0xff000000),
    900:Color(0xff000000),
  });


  /// Results Cases
  static final MaterialColor success =
  ColorHelperX.toMaterial(const Color(0xff12B76A));
  static final MaterialColor warning =
  ColorHelperX.toMaterial(const Color(0xffFFF8F1));


  static const MaterialColor danger = MaterialColor(0xffF05252, {
    50:Color(0xffFDF2F2),//
    100:Color(0xffFDE8E8),//
    200:Color(0xffeec9c9),
    300:Color(0xffF8B4B4),//
    400:Color(0xffee6d6d),
    500:Color(0xffF05252),//
    600:Color(0xffE02424),//
    700:Color(0xffC81E1E),
    800:Color(0xffa91616),
    900:Color(0xFF8A2C0D),
  });


  static const MaterialColor red = MaterialColor(0xffF05252, {
    50:Color(0xffFDF2F2),//
    100:Color(0xffFDE8E8),//
    200:Color(0xffeec9c9),
    300:Color(0xffF8B4B4),//
    400:Color(0xffee6d6d),
    500:Color(0xffF05252),//
    600:Color(0xffE02424),//
    700:Color(0xffC81E1E),
    800:Color(0xffa91616),
    900:Color(0xFF8A2C0D),
  });

  /// Grey
  static const MaterialColor grey =MaterialColor(0xff6B7280, {
    50:Color(0xffF9FAFB),//
    100:Color(0xffF3F4F6),//
    200:Color(0xffE5E7EB),//
    300:Color(0xffD1D5DB),//
    400:Color(0xff9CA3AF),//
    500:Color(0xff6B7280),//
    600:Color(0xff5c6069),
    700:Color(0xff374151),//
    800:Color(0xff252631),
    900:Color(0xFF111928),//
  });

  /// Background
  static const Color backgroundLight = Color(0xffF9FAFB);
  static const Color backgroundDark = Color(0xff20212a);

  /// Gradients
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary.shade800, primary.shade600],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
