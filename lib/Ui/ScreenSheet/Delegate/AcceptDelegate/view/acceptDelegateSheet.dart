import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/acceptDelegateSheetController.dart';

acceptDelegateSheetX({required String id}) {
  //============================================================================
  // Injection of required controls

  final AcceptDelegateSheetController controller = Get.put(AcceptDelegateSheetController());
  controller.id=id;

  //============================================================================
  // Content

  return bottomSheetX(
    isScrollEnabled: false,
    padding: EdgeInsets.only(
      bottom: 20 + MediaQuery.of(Get.context!).padding.bottom,
      top: 30,
      right: StyleX.bottomSheetPadding,
      left: StyleX.bottomSheetPadding,
    ),
    child: Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: Column(
          children: [
            TextX(
              'Accept Power of Attorney Request',
              style: TextStyleX.headerMedium,
              color: ColorX.primary,
              textAlign: TextAlign.center,
            ).fadeAnimation100,
            const SizedBox(height: 8),
            TextX(
              'Are you sure you want to accept the power of attorney request?',
              style: TextStyleX.titleSmall,
              color: Get.theme.colorScheme.secondary,
              textAlign: TextAlign.center,
            ).fadeAnimation150,
            const SizedBox(height: 25),

            /// Save & Cancel Buttons
            Row(
              children: [
                Flexible(
                  child: Obx(
                        () => ButtonStateX(
                      state: controller.buttonState.value,
                      onTap: controller.onAcceptDelegate,
                      text: "Accept",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: ButtonX.gray(
                    onTap: Get.back,
                    text: "Cancel",
                  ),
                ),
              ],
            ).fadeAnimation200
          ],
        ),
      ),
    ),
  ).then((value){
    Get.delete<AcceptDelegateSheetController>();
    return value;
  });
}
