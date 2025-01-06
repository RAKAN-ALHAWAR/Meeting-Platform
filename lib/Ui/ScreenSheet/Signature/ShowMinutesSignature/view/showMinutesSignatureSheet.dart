import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/showMinutesSignatureSheetController.dart';

showMinutesSignatureSheetX() {
  //============================================================================
  // Injection of required controls

  final ShowMinutesSignatureSheetController controller = Get.put(
    ShowMinutesSignatureSheetController(),
  );

  //============================================================================
  // Content
  return bottomSheetX(
    title: 'Sign the minutes',
    isScrollEnabled: false,
    child: Obx(
      () => AbsorbPointer(
        absorbing: controller.isDeleteLoading.value,
        child: Column(
          children: [
            if (controller.isDeleteLoading.value)
              const ContainerX(
                height: 134,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Stack(
                children: [
                  /// Signature image
                  ContainerX(
                    height: 134,
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ImageNetworkX(
                        imageUrl: controller.signature.value!,
                        height: 80,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),

                  /// Delete Icon
                  Positioned.directional(
                    textDirection: Directionality.of(Get.context!),
                    top: 8,
                    end: 8,
                    child: InkResponse(
                      onTap: controller.onDeleteSignature,
                      child: Icon(
                        Iconsax.trash,
                        color: ColorX.danger.shade500,
                      ).paddingAll(8),
                    ),
                  )
                ],
              ).fadeAnimation150,
            const SizedBox(height: 8),
            /// Save & Cancel Buttons
            Row(
              children: [
                Flexible(
                  child: ButtonX(
                    onTap: controller.onApprove,
                    text: "Approve",
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
  ).then((value) {
    Get.delete<ShowMinutesSignatureSheetController>();
    return value;
  });
}
