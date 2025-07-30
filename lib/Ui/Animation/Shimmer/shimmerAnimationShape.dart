part of "../animation.dart";

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this class }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Ready-made shapes for frequently used elements in the project
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ShimmerAnimationShapeX {
  /// Search Bar
  static Widget searchBar() {
    return const Padding(
      padding:
          EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp, vertical: 16),
      child: Row(
        children: [
          Flexible(
              child: ShimmerAnimationX(
            height: StyleX.buttonHeight,
          )),
          SizedBox(width: 10),
          ShimmerAnimationX(
            width: StyleX.buttonHeight,
            height: StyleX.buttonHeight,
          )
        ],
      ),
    );
  }

  /// Donation Card
  static Widget donationCard({bool isSmall = false}) {
    return ShimmerAnimationX(
      height: StyleX.donationCardHeight,
      width: isSmall ? StyleX.donationCardWidthSM:double.maxFinite,
      margin: isSmall
          ? const EdgeInsetsDirectional.only(end: 14)
          : const EdgeInsetsDirectional.only(bottom: 14),
    );
  }

  /// Deduction Card
  static Widget deductionCard({bool isSmall = false}) {
    return ShimmerAnimationX(
      height: StyleX.deductionCardHeight,
      width: isSmall ? StyleX.deductionCardWidthSM:double.maxFinite,
      margin: isSmall
          ? const EdgeInsetsDirectional.only(end: 14)
          : const EdgeInsetsDirectional.only(bottom: 14),
    );
  }

  /// Label Input
  static Widget labelInput({double width = 100}) {
    return ShimmerAnimationX(
      height: 22,
      width: width,
    );
  }

  /// Filed Input
  static Widget filedInput({double width = double.maxFinite}) {
    return ShimmerAnimationX(
      height: StyleX.inputHeight,
      width: width,
      margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
    );
  }

  /// Button
  static Widget button({double width = double.maxFinite,EdgeInsets? margin}) {
    return ShimmerAnimationX(
      height: StyleX.buttonHeight,
      width: width,
      margin: margin??const EdgeInsetsDirectional.symmetric(vertical: 5),
    );
  }

  /// Product Card
  static Widget productCard({bool isSmall = false}) {
    return ShimmerAnimationX(
      width: isSmall
          ? StyleX.productCardWidth
          : MediaQuery.of(Get.context!).size.width / 2 - StyleX.hPaddingApp - 5,
      height: StyleX.productCardHeight,
      margin:
          isSmall ? const EdgeInsetsDirectional.only(end: 14) : EdgeInsets.zero,
    );
  }
}
