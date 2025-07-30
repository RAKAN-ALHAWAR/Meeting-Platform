import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/Data/Form/suggestion/add_suggestion.dart';
import 'package:meeting/Data/Model/attachment/attachment.dart';
import 'package:meeting/UI/Widget/widget.dart';

import '../../../../../Config/config.dart';
import '../../../../../Data/data.dart';

class AddSuggestionController extends GetxController {
  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;
  RxList<PlatformFile> files = <PlatformFile>[].obs;
  late GlobalKey<FormState> formKey;
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late TextEditingController filesController =
      TextEditingController(text: getUploadedMessage);

  //============================================================================
  // Functions

  onAddSuggestion() async {
    if(isLoading.isFalse){
      if (formKey.currentState!.validate()) {
        try {
          buttonState.value = ButtonStateEX.loading;
          isLoading.value = true;

          List<AttachmentX> attachments = [];
          for (var x in files) {
            try {
              var result = await DatabaseX.uploadAttachment(
                file: File(x.xFile.path),
              );
              attachments.add(result.$1);
            } catch (_) {}
          }

          var message = await DatabaseX.addSuggestion(
            form: AddSuggestionFormX(
              title: title.text,
              message: description.text,
              attachmentsId: attachments.map((e) => e.id).toList(),
            ),
          );

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );
          Get.back(result: true);
          if (message != null) {
            ToastX.success(message: message);
          }
        } catch (e) {
          buttonState.value = ButtonStateEX.failed;
          ToastX.error(message: e.toString());
        }
        isLoading.value = false;

        /// Reset the button state
        Timer(
          const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
              () {
            buttonState.value = ButtonStateEX.normal;
          },
        );
      } else {
        autoValidate = AutovalidateMode.always;
      }
    }
  }

  getSize(PlatformFile file) {
    var x = FunctionX.formatFileSize(file.size);
    return '${x.$2.tr} ${x.$1}';
  }

  onSelectFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    bool isHasDuplicate = false;
    bool isHasFileToLarge = false;
    if (result != null) {
      for (var file in result.files) {
        // Check if the file is already in the list
        bool isAlreadySelected =
            files.any((f) => f.name == file.name && f.size == file.size);

        if (isAlreadySelected) {
          // Show a message that the file is already selected
          isHasDuplicate = true;
        } else if (file.size > 100 * 1024 * 1024) {
          // Check if the file size exceeds 100 MB
          isHasFileToLarge = true;
        } else {
          // Add valid files to the list
          files.add(file);
        }
      }
    }
    if (isHasDuplicate && isHasFileToLarge) {
      ToastX.error(
        title: "Duplicate and Large Files",
        message:
            "Some files are duplicates and have been deselected, while others exceeding 100 MB in size have been removed.",
      );
    } else if (isHasFileToLarge) {
      ToastX.error(
        title: "File Too Large",
        message:
            "The selected files exceeding 100 MB in size have been removed",
      );
    } else if (isHasDuplicate) {
      ToastX.error(
        title: "Duplicate File",
        message:
            "Duplicate files that were previously selected have been deselected",
      );
    }

    // Update the text field or controller with the number of valid files
    filesController.text = getUploadedMessage;
  }

  onDeleteFile(File file) {
    files.removeWhere((element) => element.path == file.path);
    filesController.text = getUploadedMessage;
  }

  String get getUploadedMessage {
    if (files.isEmpty) {
      return 'No file uploaded yet'.tr;
    } else if (files.length == 1) {
      return 'One file uploaded'.tr;
    } else if (files.length == 2) {
      return 'uploadedFilesDual'.tr;
    } else if (files.length > 2 && files.length < 11) {
      return 'uploadedFilesFew'
          .trParams({'fileCount': files.length.toString()});
    } else {
      return 'uploadedFilesMany'
          .trParams({'fileCount': files.length.toString()});
    }
  }
}
