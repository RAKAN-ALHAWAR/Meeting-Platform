import 'package:alh_pdf_view/alh_pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/UI/Animation/animation.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Basic/Utils/future_builder.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';

import '../../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';

class MeetingMinutesView extends GetView<MeetingMinutesController> {
  const MeetingMinutesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Meeting Minutes'),
      body: SafeArea(
        child: FutureBuilderX(
          key: controller.futureBuilderKey,
          future: controller.getData,
          loading: Padding(
            padding: StyleX.paddingApp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const ShimmerAnimationX(height: 550),
              const SizedBox(height: 16),
                Row(children: [
                  Flexible(child: ShimmerAnimationShapeX.button()),
                  const SizedBox(width: 8),
                  Flexible(child: ShimmerAnimationShapeX.button()),
                ],)
            ],),
          ),
          child: (data) => Padding(
            padding: StyleX.paddingApp,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.meeting.value.isCloseRecord)
                    MessageCardX(
                      color: ColorX.green,
                      icon: Iconsax.tick_circle,
                      text: 'The minutes have been closed',
                    ).marginOnly(bottom: 8).fadeAnimation150,
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const double a4AspectRatio = 1122.5 / 793.7;
                        final double availableWidth = constraints.maxWidth;
                        final double availableHeight = constraints.maxHeight;
                        double calculatedHeight = availableWidth * a4AspectRatio;
                        if (calculatedHeight > availableHeight) {
                          calculatedHeight = availableHeight;
                        }
                        final double calculatedWidth = calculatedHeight / a4AspectRatio;
                        return ContainerX(
                          width: calculatedWidth,
                          height: calculatedHeight,
                          radius: StyleX.radiusLg,
                          isBorder: false,
                          padding: const EdgeInsets.all(12),
                          child: AlhPdfView(
                            autoSpacing: false,
                            fitEachPage: false,
                            filePath: controller.file.value.path,
                            swipeHorizontal: true,
                            backgroundColor: Get.theme.cardColor,
                          ),
                        ).fadeAnimation200;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        child: AbsorbPointer(
                          absorbing: controller.meeting.value.isCloseRecord || controller.myAttendance.value.signature!=null,
                          child: Opacity(
                            opacity: controller.meeting.value.isCloseRecord || controller.myAttendance.value.signature!=null
                                ? 0.5
                                : 1,
                            child: ButtonStateX(
                              text: 'Signature',
                              state: controller.buttonStateSignature.value,
                              onTap: controller.onSignature,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: AbsorbPointer(
                          absorbing: !controller.meeting.value.isCloseRecord,
                          child: Opacity(
                            opacity: controller.meeting.value.isCloseRecord
                                ? 1
                                : 0.5,
                            child: ButtonStateX.second(
                              text: 'Download the minutes',
                              state:
                                  controller.buttonStateDownloadMinutes.value,
                              onTap: controller.onDownloadMinutes,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).fadeAnimation250,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
