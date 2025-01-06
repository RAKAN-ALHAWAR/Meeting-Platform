import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/controller.dart';

class ProfileImageSectionX extends GetView<EditProfileController> {
  const ProfileImageSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.changeImage,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          /// Image
          GetBuilder<EditProfileController>(
            builder: (controller) => CircleAvatar(
              radius: 49,
              backgroundColor: Get.theme.cardColor,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Get.theme.cardColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ImageNetworkX(
                    imageUrl: controller.image != null
                        ? controller.image!.path
                        : controller.app.user.value.imageUrl ?? "",
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                    isFile: controller.image != null,
                    failed: Center(
                      child: TextX(
                        controller.app.user.value.name[0],
                        style: TextStyleX.headerLarge,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ).fadeAnimation200,
            ),
          ),

          /// Upload Icon
          Positioned(
            left: 4.0,
            bottom: 0.0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 14,
              child:  const Icon(
                Iconsax.export_1,
                color: Colors.white,
                size: 17,
              ),
            ).fadeAnimation200,
          ),
        ],
      ),
    );
  }
}
