import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/fileWithDeleteCard.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:signature/signature.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/addSignatureSheetController.dart';

addSignatureSheetX({bool isMinutes = false}) {
  //============================================================================
  // Injection of required controls

  final AddSignatureSheetController controller = Get.put(
    AddSignatureSheetController(),
  );

  //============================================================================
  // Content
  return bottomSheetX(
    title: isMinutes?'Sign the minutes':'Add new signature',
    isScrollEnabled: false,
    child: Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: Column(
          children: [
            /// Select method tab
            TabSegmentX(
              controller: controller.signatureVia,
              tabs: {
                1: 'Upload image'.tr,
                2: 'Signature drawing'.tr,
              },
            ).marginOnly(bottom: 16).fadeAnimation150,
            if (controller.isImage.value && controller.image.value == null)
              InkWell(
                onTap: controller.uploadImage,
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorX.grey.shade50,
                    border: DashedBorder.fromBorderSide(
                      dashLength: 3,
                      spaceLength: 3,
                      side: BorderSide(color: ColorX.grey.shade200, width: 1),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(StyleX.radius),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.isLoadingUpload.isTrue)
                        const CircularProgressIndicator(),
                      if (controller.isLoadingUpload.isFalse)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.document_upload,
                              color: Get.theme.colorScheme.secondary,
                            ),
                            const TextX(
                              'Select image',
                              fontWeight: FontWeight.w600,
                            ).marginOnly(top: 8, bottom: 4),
                            TextX(
                              'Please upload a photo with your signature and a white background',
                              style: TextStyleX.supTitleMedium,
                              textAlign: TextAlign.center,
                            ).paddingSymmetric(horizontal: 20),
                          ],
                        ),
                    ],
                  ).fadeAnimation150,
                ).fadeAnimation150,
              ),
            if (controller.isImage.value && controller.image.value != null)
              FileWithDeleteCardX(
                file: File(controller.image.value!.path),
                name: controller.image.value!.name,
                onDelete: controller.onDeleteImage,
                size: '${controller.imageSize.value.$2!.tr} ${controller.imageSize.value.$1!}',
              ).fadeAnimation150,
            if (controller.isImage.isFalse)
              Column(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: DashedBorder.fromBorderSide(
                        dashLength: 5,
                        spaceLength: 4,
                        side: BorderSide(color: ColorX.grey.shade200, width: 1),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(StyleX.radius),
                      ),
                    ),
                    child: Signature(
                      controller: controller.signatureController.value,
                      height: 140,
                      backgroundColor: Colors.white,
                    ),
                  ).fadeAnimation150,
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (!controller.isOpenPenWidth.value)
                        InkWell(
                          onTap: controller.onTapPenWidth,
                          child: ContainerX(
                            width: 46,
                            height: 46,
                            borderColor: ColorX.grey.shade300,
                            padding: EdgeInsets.zero,
                            child: const Center(
                              child: Icon(IconsaxPlusLinear.brush_2),
                            ),
                          ),
                        ).fadeAnimationX(100,
                            alignment: AlignmentDirectional.centerStart
                                .resolve(Directionality.of(Get.context!))),
                      if (controller.isOpenPenWidth.value)
                        ContainerX(
                          height: 46,
                          borderColor: ColorX.grey.shade300,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => controller.onChangePenWidth(10),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      controller.penStrokeWidth.value == 10
                                          ? ColorX.primary.shade50
                                          : Colors.transparent,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.black),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.onChangePenWidth(8),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      controller.penStrokeWidth.value == 8
                                          ? ColorX.primary.shade50
                                          : Colors.transparent,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        radius: 4,
                                        backgroundColor: Colors.black),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.onChangePenWidth(6),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      controller.penStrokeWidth.value == 6
                                          ? ColorX.primary.shade50
                                          : Colors.transparent,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        radius: 3,
                                        backgroundColor: Colors.black),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.onChangePenWidth(4),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      controller.penStrokeWidth.value == 4
                                          ? ColorX.primary.shade50
                                          : Colors.transparent,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.black),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.onChangePenWidth(2),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      controller.penStrokeWidth.value == 2
                                          ? ColorX.primary.shade50
                                          : Colors.transparent,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        radius: 1.5,
                                        backgroundColor: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).fadeAnimationX(100,
                            alignment: AlignmentDirectional.centerStart
                                .resolve(Directionality.of(Get.context!))),
                      const SizedBox(width: 16),
                      ContainerX(
                        height: 46,
                        borderColor: ColorX.grey.shade300,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            AbsorbPointer(
                              absorbing: controller.isHasDrawing.isFalse,
                              child: InkWell(
                                onTap: controller.clearDraw,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    IconsaxPlusLinear.eraser_1,
                                    color: controller.isHasDrawing.isFalse
                                        ? ColorX.grey.shade400
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            AbsorbPointer(
                              absorbing: controller.drawingSteps.value ==
                                      controller.drawingCurrentSteps.value ||
                                  controller.drawingCurrentSteps.value == 0,
                              child: InkWell(
                                onTap: controller.redoDraw,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    IconsaxPlusLinear.redo,
                                    color: controller.drawingSteps.value ==
                                                controller.drawingCurrentSteps
                                                    .value ||
                                            controller.drawingCurrentSteps
                                                    .value ==
                                                0
                                        ? ColorX.grey.shade400
                                        : null,
                                  ),
                                ),
                              ).marginSymmetric(horizontal: 5),
                            ),
                            AbsorbPointer(
                              absorbing: controller.drawingSteps.value == 0,
                              child: InkWell(
                                onTap: controller.undoDraw,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    IconsaxPlusLinear.undo,
                                    color: controller.drawingSteps.value == 0
                                        ? ColorX.grey.shade400
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).fadeAnimationX(100,
                          alignment: AlignmentDirectional.centerStart
                              .resolve(Directionality.of(Get.context!))),
                    ],
                  )
                ],
              ),
            const SizedBox(height: 11),

            /// Save & Cancel Buttons
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => ButtonStateX(
                      state: controller.buttonState.value,
                      onTap: controller.onSave,
                      text: isMinutes?'Approve':'Save',
                      disabled: controller.isDone.isFalse,
                      colorDisabledButton: Get.context!.isDarkMode
                          ? ColorX.primary.shade300.withOpacity(0.2)
                          : ColorX.primary.withOpacity(0.4),
                      colorDisabledBorder: Colors.transparent,
                      colorDisabledText: Get.context!.isDarkMode
                          ? Colors.white38
                          : Colors.white,
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
  ).then((value) {
    Get.delete<AddSignatureSheetController>();
    return value;
  });
}
