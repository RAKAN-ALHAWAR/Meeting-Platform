import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../Config/config.dart';
import '../../../../UI/Widget/widget.dart';

minutesSignatureSuccessSheetX() {
  return bottomSheetX(
    isScrollEnabled: false,
    padding: EdgeInsets.only(
      bottom: 20 + MediaQuery.of(Get.context!).padding.bottom,
      top: 30,
      right: StyleX.bottomSheetPadding,
      left: StyleX.bottomSheetPadding,
    ),
    child: Column(
      children: [
        ContainerX(
          radius: 20,
          color: ColorX.primary.shade50,
          height: 85,
          width: 85,
          isBorder: false,
          child: Center(
            child: Icon(
              Icons.check_rounded,
              size: 38,
              color: ColorX.primary.shade800,
            ),
          ),
        ).fadeAnimation100,
        const SizedBox(height: 24),
        TextX(
          'Your signature has been approved successfully',
          style: TextStyleX.headerMedium,
          color: ColorX.primary.shade800,
          textAlign: TextAlign.center,
        ).fadeAnimation200,
        const SizedBox(height: 8),
        TextX(
          'The minutes will be available for download after the signatures are completed and the meeting is closed by the meeting organizer',
          style: TextStyleX.titleSmall,
          color: Get.theme.colorScheme.secondary,
          textAlign: TextAlign.center,
        ).fadeAnimation250,
        const SizedBox(height: 25),

        /// Ok Buttons
        ButtonX(
          onTap: Get.back,
          text: "OK",
        ).fadeAnimation300
      ],
    ),
  );
}
