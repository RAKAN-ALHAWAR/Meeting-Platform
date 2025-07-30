import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../controller/controller.dart';
import 'suggestionDetails.dart';
import 'suggestionForm.dart';

class SuggestionsSection extends GetView<MeetingDetailsController> {
  const SuggestionsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        TextX(
          'Meeting Suggestions',
          style: TextStyleX.titleLarge,
          size: 16,
        ).fadeAnimation200,
        const SizedBox(height: 6),

        /// Subtitle
        TextX(
          'We appreciate and value your suggestion, it will undoubtedly help us in the development process',
          style: TextStyleX.titleSmall,
        ).fadeAnimation250,
        const SizedBox(height: 12),

        /// Content
        ContainerX(
          child: Obx(
            () {
              /// Suggestion Details
              if (controller.mySuggestion.value != null) {
                return const SuggestionDetails().fadeAnimation300;
              } else {
                /// Suggestion Form
                return const SuggestionForm().fadeAnimation300;
              }
            },
          ),
        ).fadeAnimation150,
      ],
    );
  }
}
