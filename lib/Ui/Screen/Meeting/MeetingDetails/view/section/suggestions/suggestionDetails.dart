import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../Config/Translation/translation.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../controller/controller.dart';

class SuggestionDetails extends GetView<MeetingDetailsController> {
  const SuggestionDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Date added Title
          const TextX(
            'Date added',
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 6),

          /// Date added
          TextX(
            DateFormat(
              'EEEE h:mm a, d MMMM yyyy',
              TranslationX.getLanguageCode,
            ).format(controller.mySuggestion.value!.createdAt),
            style: TextStyleX.titleSmall,
            color: ColorX.grey.shade500,
          ),

          /// Line
          Divider(color: ColorX.grey.shade100).marginSymmetric(vertical: 5),

          /// Suggestion Title
          const TextX(
            'Suggestion Title',
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 6),

          /// Suggestion Title Data
          TextX(
            controller.mySuggestion.value?.title ?? '',
            style: TextStyleX.titleSmall,
            color: ColorX.grey.shade500,
          ),

          /// Line
          Divider(color: ColorX.grey.shade100).marginSymmetric(vertical: 5),

          /// Suggestion Description Title
          const TextX(
            'Suggestion Description',
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 6),

          /// Suggestion Description
          TextX(
            controller.mySuggestion.value?.message ?? '',
            style: TextStyleX.titleSmall,
            color: ColorX.grey.shade500,
          ),
        ],
      ),
    );
  }
}
