import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../Core/core.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../controller/controller.dart';

class SuggestionForm extends GetView<MeetingDetailsController> {
  const SuggestionForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          /// Input Form
          Form(
            key: controller.formKeySuggestion,
            autovalidateMode: controller.autoValidateSuggestion,
            child: Column(
              children: [
                /// Title
                TextFieldX(
                  controller: controller.suggestionTitle,
                  label: 'Suggestion Title',
                  textInputAction: TextInputAction.next,
                  validate: ValidateX.title,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 4),

                /// Description
                TextFieldX(
                  controller: controller.suggestionDescription,
                  label: 'Suggestion Description',
                  textInputAction: TextInputAction.done,
                  validate: ValidateX.description,
                  textInputType: TextInputType.multiline,
                  minLines: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          /// Save Button
          ButtonStateX(
            text: 'Save and send',
            onTap: controller.onSendSuggestion,
            state: controller.buttonStateSuggestion.value,
            marginVertical: 0,
          )
        ],
      ),
    );
  }
}
