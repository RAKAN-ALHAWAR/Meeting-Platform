import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/UI/Widget/widget.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../Widget/Custom/Card/fileWithDeleteCard.dart';
import '../controller/controller.dart';

class AddSuggestionView extends GetView<AddSuggestionController> {
  const AddSuggestionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Add a new suggestion'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: StyleX.paddingApp,
          child: ContainerX(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Obx(
              () => AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextX(
                      'Add a suggestion',
                      style: TextStyleX.titleLarge,
                    ).fadeAnimation100,
                    const SizedBox(height: 7),
                    TextX(
                      'We value and appreciate your suggestion, as it will undoubtedly aid us in the development process',
                      style: TextStyleX.titleSmall,
                      color: Get.theme.colorScheme.secondary,
                    ).fadeAnimation150,
                    const SizedBox(height: 16),
                    Form(
                      key: controller.formKey,
                      autovalidateMode: controller.autoValidate,
                      child: Column(
                        children: [
                          TextFieldX(
                            controller: controller.title,
                            label: 'Suggestion Title',
                            textInputAction: TextInputAction.next,
                            validate: ValidateX.title,
                            textInputType: TextInputType.text,
                          ).fadeAnimation200,
                          TextFieldX(
                            controller: controller.description,
                            label: 'Suggestion Description',
                            textInputAction: TextInputAction.done,
                            validate: ValidateX.description,
                            textInputType: TextInputType.multiline,
                            minLines: 4,
                          ).paddingSymmetric(vertical: 4).fadeAnimation250,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFieldX(
                                  label: 'Attachments',
                                  controller: controller.filesController,
                                  colorText: ColorX.grey.shade600,
                                  onlyRead: true,
                                  borderRadius:
                                      const BorderRadiusDirectional.horizontal(
                                    start: Radius.circular(StyleX.radius),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: controller.onSelectFiles,
                                child: ContainerX(
                                  isBorder: true,
                                  borderRadius:
                                      const BorderRadiusDirectional.horizontal(
                                    end: Radius.circular(StyleX.radius),
                                  ),
                                  height: StyleX.inputHeight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  child: const Center(
                                    child: TextX(
                                      'Browse',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ).marginSymmetric(vertical: 5),
                            ],
                          ).fadeAnimation300,
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Column(
                      children: [
                        for (var file in controller.files)
                          FileWithDeleteCardX(
                            file: File(file.xFile.path),
                            name: file.name,
                            onDelete: controller.onDeleteFile,
                            size: controller.getSize(file),
                          ).fadeAnimation150,
                        const SizedBox(height: 6),
                        ButtonStateX(
                          text: 'Save and send',
                          onTap: controller.onAddSuggestion,
                          state: controller.buttonState.value,
                        ).fadeAnimation350
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ).fadeAnimation50,
        ),
      ),
    );
  }
}
