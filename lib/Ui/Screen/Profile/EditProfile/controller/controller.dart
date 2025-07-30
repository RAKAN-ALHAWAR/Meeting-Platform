import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Data/Form/profile/update_profile.dart';
import '../../../../../../../Core/core.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Data/data.dart';

class EditProfileController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  late int countryCode = 966;

  XFile? image;
  final ImagePicker picker = ImagePicker();

  /// Input Filed
  late GlobalKey<FormState> formKey;
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  late TextEditingController name =
      TextEditingController(text: app.user.value.name);
  late TextEditingController idNumber =
      TextEditingController(text: app.user.value.idNumber.toString());
  late TextEditingController phone =
      TextEditingController(text: app.user.value.phone);
  late TextEditingController email =
      TextEditingController(text: app.user.value.email);
  late TextEditingController category =
      TextEditingController(text: app.user.value.roles.firstOrNull?.name);
  late TextEditingController jobTitle =
      TextEditingController(text: app.user.value.jobTitle);

  //============================================================================
  // Functions

  void onChangeCountryCode(String val) => countryCode = int.parse(val);

  changeImage() async {
    /// Open the user's photo gallery to select a photo
    var x = await picker.pickImage(source: ImageSource.gallery);

    /// If an image is selected, the data is updated
    if (x != null) {
      image = x;
      update();
    }
  }

  onEdit() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        try {
          String? message = await DatabaseX.updateProfile(
            form: UpdateProfileFormX(
              name: name.text,
              idNumber: idNumber.text,
              phone: phone.text,
              /// TODO: here save phone without country code
              // phone: '+$countryCode${phone.text}'),
            ),
          );

          app.user.value.name = name.text;
          app.user.value.idNumber = idNumber.text.toIntX;
          app.user.value.phone = phone.text;
          /// TODO: here save phone without country code
          // app.user.value.phone = '+$countryCode${phone.text}';
          app.update();

          if (image != null) {
            message = (await DatabaseX.uploadProfileImage(
                  image: File(image!.path),
                )) ??
                message;
            app.user.value = await DatabaseX.getProfile();
          }

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// Close the profile edite screen
          Get.back();
          if (message != null && message.isNotEmpty) {
            ToastX.success(message: message);
          }
        } catch (error) {
          ToastX.error(message: error.toString());
          buttonState.value = ButtonStateEX.failed;
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
}
