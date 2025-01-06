import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../../../Config/Translation/translation.dart';
import '../../../../../../../Config/config.dart';
import '../../../controller/controller.dart';

class VotingStartAt extends GetView<MeetingDetailsController> {
  const VotingStartAt({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      /// Voting Start at message
      () => MessageCardX(
        color: ColorX.blue,
        icon: Iconsax.info_circle,
        text: '${'Voting starts at'.tr} ${DateFormat(
          'h:mm a, d MMMM yyyy',
          TranslationX.getLanguageCode,
        ).format(controller.meeting.value.voteStartAt!)}',
      ).fadeAnimation250,
    );
  }
}
