import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../Widget/Custom/Card/messageCard.dart';
import '../../../../../../Widget/widget.dart';
import '../../../controller/controller.dart';

class PreviousVote extends GetView<MeetingDetailsController> {
  const PreviousVote({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        /// Check if there are previous answers
        if (controller.myAnswersIDs.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              TextX(
                'Your previous responses to voting questions',
                style: TextStyleX.titleSmall,
                color: ColorX.grey.shade600,
              ).fadeAnimation250,
              const SizedBox(height: 12),

              /// Questions and answers
              for (int i = 0; i < controller.questions.length; i++)
                ContainerX(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Question index
                      TextX(
                        '${i + 1} ${'of'.tr} ${controller.questions.length}',
                        color: ColorX.primary.shade500,
                        size: 13,
                      ).fadeAnimation350,
                      const SizedBox(height: 12),

                      /// Question text
                      TextX(
                        controller.questions[i].text,
                        fontWeight: FontWeight.w700,
                      ).fadeAnimation350,
                      const SizedBox(height: 10),

                      /// User's answers
                      TextX(
                        controller.myAnswersIDs
                            .where((entry) =>
                                entry.$1 == controller.questions[i].id)
                            .map((entry) {
                          return controller.questions[i].answers
                                  .firstWhereOrNull(
                                    (answer) => answer.id == entry.$2,
                                  )
                                  ?.text ??
                              'Unknown';
                        }).join(', '),
                        style: TextStyleX.titleSmall,
                        color: ColorX.grey.shade500,
                      ).fadeAnimation350,
                    ],
                  ),
                ).fadeAnimation300,
              const SizedBox(height: 12),
            ],
          );
        } else {
          /// Message if no answers
          return MessageCardX(
            text: 'Voted, thanks for your contribution',
            color: ColorX.green,
            icon: Iconsax.tick_circle,
          ).fadeAnimation250;
        }
      },
    );
  }
}
