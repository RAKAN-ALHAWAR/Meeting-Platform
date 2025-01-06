import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/deleteSignatureSheetController.dart';

deleteSignatureSheetX() {
  //============================================================================
  // Injection of required controls

  final DeleteSignatureSheetController controller = Get.put(DeleteSignatureSheetController());

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
            ContainerX(
              radius: 20,
              color: ColorX.danger.shade100,
              height: 85,
              width: 85,
              isBorder: false,
              child: Center(
                child: Icon(
                  IconsaxPlusBold.trash,
                  size: 38,
                  color: ColorX.danger.shade600,
                ),
              ),
            ).fadeAnimation100,
            const SizedBox(height: 24),
            TextX(
              'Delete signature',
              style: TextStyleX.headerMedium,
              color: ColorX.danger.shade600,
              textAlign: TextAlign.center,
            ).fadeAnimation200,
            const SizedBox(height: 8),
            TextX(
              'Are you sure you want to delete the signature',
              style: TextStyleX.titleSmall,
              color: Get.theme.colorScheme.secondary,
              textAlign: TextAlign.center,
            ).fadeAnimation250,
            const SizedBox(height: 25),

            /// Save & Cancel Buttons
            Row(
              children: [
                Flexible(
                  child: ButtonX(
                    onTap: Get.back,
                    text: "Cancel",
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Obx(
                    () => ButtonStateX.dangerous(
                      state: controller.buttonState.value,
                      onTap: controller.onDeleteSignature,
                      text: "Delete signature",
                    ),
                  ),
                ),
              ],
            ).fadeAnimation300
          ],
        ),
      ),
    ),
  ).then((value){
    Get.delete<DeleteSignatureSheetController>();
    return value;
  });
}
