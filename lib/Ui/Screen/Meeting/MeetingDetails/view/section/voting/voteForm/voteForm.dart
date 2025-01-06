import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../Config/config.dart';
import '../../../../../../../Widget/widget.dart';
import '../../../../controller/controller.dart';
import 'voteFormDetails.dart';
import 'voteFormQuestions.dart';

class VoteForm extends GetView<MeetingDetailsController> {
  const VoteForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Subtitle
          TextX(
            'Please answer the following questions and send them so that we can develop based on what suits you',
            style: TextStyleX.titleSmall,
            color: ColorX.grey.shade600,
          ).fadeAnimation250,
          const SizedBox(height: 12),

          /// Vote Details
          const VoteFormDetails().fadeAnimation300,
          const SizedBox(height: 12),

          /// Questions
          const VoteFormQuestions().fadeAnimation400,
        ],
      ),
    );
  }
}
