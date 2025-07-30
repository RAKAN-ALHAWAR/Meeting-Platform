import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Data/Model/user/mini_user.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../Config/config.dart';
import '../../../../Widget/widget.dart';
import '../controller/selectionDelegateUserSheetControllerX.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// View donation projects to choose one of them with a search bar
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

selectionDelegateUserSheet({
  required List<MiniUserX> users,
  required MiniUserX? selectedUser,
}) {
  //============================================================================
  // Injection of required controls

  final SelectionDelegateUserSheetControllerX controller =
      Get.put(SelectionDelegateUserSheetControllerX());
  controller.users = users;
  controller.results.value = users;
  controller.delegateSelected.value = selectedUser;

  //============================================================================
  // Content
  return bottomSheetX(
    isPaddingBottom: false,
    title: "Select the client's name",
    child: SizedBox(
      height: 350,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldX(
              color: Get.theme.cardColor,
              controller: controller.search,
              hint: "Type here to search for the client's name",
              icon: Iconsax.search_normal_1,
              iconSize: 20,
              onChanged: controller.onSearching,
            ).fadeAnimation200,
            if (controller.results.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var data in controller.results)
                        RadioButtonX<String?>(
                          groupValue: controller.delegateSelected.value?.id,
                          value: data.id,
                          onChanged: (_) async =>
                              await controller.onChange(data),
                          label: data.name,
                        ).fadeAnimation250
                    ],
                  ),
                ),
              ),
            if (controller.results.isEmpty)
              Expanded(
                child: Center(
                  child: const MessageCardX(
                    color: ColorX.grey,
                    text:
                        'No search results.\n Try searching for someone else.',
                  ).fadeAnimation250,
                ),
              ),
            ButtonX(
              onTap: controller.onSave,
              text: 'Save',
            ).marginOnly(top: 10).fadeAnimation300,
          ],
        ),
      ),
    ),
  ).then((value) {
    var x = controller.delegateSelected.value;
    Get.delete<SelectionDelegateUserSheetControllerX>();
    return x;
  });
}
