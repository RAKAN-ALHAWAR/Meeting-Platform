import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../Data/Enum/selection_type_status.dart';
import '../../../../../../../Widget/widget.dart';
import '../../../../controller/controller.dart';

class VoteFormQuestions extends GetView<MeetingDetailsController> {
  const VoteFormQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ContainerX(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Use ListView.builder for better performance
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.questions.length,
              itemBuilder: (context, i) {
                final question = controller.questions[i];
                final isSingleSelection =
                    question.selectionType == SelectionTypeStatusX.single;
                final isMultipleSelection =
                    question.selectionType == SelectionTypeStatusX.multiple;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (i != 0) const SizedBox(height: 12),
                    TextX(
                      '${i + 1}. ${question.text}',
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 10),

                    /// Render Radio Buttons for Single Selection
                    if (isSingleSelection)
                      ...question.answers.map((answer) {
                        return _buildRadioButton(question, answer);
                      }),

                    /// Render Checkboxes for Multiple Selection
                    if (isMultipleSelection)
                      ...question.answers.map((answer) {
                        return _buildCheckBox(question, answer);
                      }),
                  ],
                ).fadeAnimation450;
              },
            ),

            const SizedBox(height: 12),

            /// Send Vote Button
            ButtonStateX(
              text: 'Save and send',
              onTap: controller.onSendVote,
              state: controller.buttonStateVote.value,
              marginVertical: 0,
            ),
          ],
        ).fadeAnimation500,
      ),
    );
  }

  /// Helper method for building a Radio Button
  Widget _buildRadioButton(dynamic question, dynamic answer) {
    return RadioButtonX(
      groupValue: controller.myAnswersIDs
          .firstWhereOrNull((element) => element.$1 == question.id)
          ?.$2,
      value: answer.id,
      label: answer.text,
      onChanged: (val) {
        if (val != null) {
          controller.myAnswersIDs
              .removeWhere((element) => element.$1 == question.id);
          controller.myAnswersIDs.add((question.id, val));
        }
      },
    );
  }

  /// Helper method for building a Checkbox
  Widget _buildCheckBox(dynamic question, dynamic answer) {
    return CheckBoxX(
      value: controller.myAnswersIDs.firstWhereOrNull(
            (element) => element == (question.id, answer.id),
          ) !=
          null,
      label: answer.text,
      onChanged: (val) {
        if (val) {
          controller.myAnswersIDs.add((question.id, answer.id));
        } else {
          controller.myAnswersIDs.remove((question.id, answer.id));
        }
      },
    );
  }
}
