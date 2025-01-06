import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../Config/Translation/translation.dart';
import '../../../../../../../../Config/config.dart';
import '../../../../../../../../Core/core.dart';
import '../../../../../../../Widget/widget.dart';
import '../../../../controller/controller.dart';

class VoteFormDetails extends GetView<MeetingDetailsController> {
  const VoteFormDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ContainerX(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Voting Start Date
            TextX(
              'Voting Start',
              color: ColorX.grey.shade500,
            ).fadeAnimation350,
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Iconsax.clock,
                  color: ColorX.grey.shade400,
                  size: 18,
                ),
                const SizedBox(width: 10),
                TextX(
                  DateFormat(
                    'h:mm a, d MMMM yyyy',
                    TranslationX.getLanguageCode,
                  ).format(controller.meeting.value.voteStartAt!),
                  color: ColorX.green.shade500,
                  fontWeight: FontWeight.w500,
                  size: 14,
                ),
              ],
            ).fadeAnimation350,
            const SizedBox(height: 12),

            /// Voting End Date
            TextX(
              'Voting End',
              color: ColorX.grey.shade500,
            ).fadeAnimation400,
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  DeviseX.isLTR ? Iconsax.arrow_right : Iconsax.arrow_left,
                  color: ColorX.grey.shade400,
                  size: 18,
                ),
                const SizedBox(width: 10),
                TextX(
                  DateFormat(
                    'h:mm a, d MMMM yyyy',
                    TranslationX.getLanguageCode,
                  ).format(controller.meeting.value.voteEndAt!),
                  color: ColorX.red.shade500,
                  fontWeight: FontWeight.w500,
                  size: 14,
                ),
              ],
            ).fadeAnimation400,
            const SizedBox(height: 12),

            /// Number of Questions
            TextX(
              'Number of Questions',
              color: ColorX.grey.shade500,
            ).fadeAnimation450,
            const SizedBox(height: 6),
            TextX(
              controller.questions.length.toString(),
              fontWeight: FontWeight.w500,
              size: 14,
            ).fadeAnimation450,
          ],
        ),
      ),
    );
  }
}
