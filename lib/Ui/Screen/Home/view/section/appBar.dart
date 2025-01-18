import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../controller/controller.dart';

class AppBarForHome extends GetView<HomeController> {
  const AppBarForHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              /// Profile Image
              ContainerX(
                radius: 17,
                height: 60,
                width: 60,
                borderWidth: 2,
                borderColor: Get.theme.cardColor,
                isBorder: true,
                padding: EdgeInsets.zero,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Obx(() => ImageNetworkX(
                      /// تحديث الصورة عند تغييرها
                      key: Key(
                        controller.app.user.value.imageUrl ?? "profile image",
                      ),
                      height: 58,
                      width: 58,
                      imageUrl: controller.app.user.value.imageUrl ?? "",
                      fit: BoxFit.cover,

                      /// Empty State
                      empty: Center(
                        child: controller.app.user.value.name.isNotEmpty
                            ? TextX(
                          controller.app.user.value.name[0],
                          style: TextStyleX.headerLarge,
                          fontWeight: FontWeight.w600,
                          color: ColorX.primary,
                        )
                            : const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),),
                  ),
                ),
              ).fadeAnimation100,
              const SizedBox(width: 8),

              /// Name & Job Title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextX(
                    '${controller.app.user.value.name} 👋',
                    style: TextStyleX.titleLarge,
                  ),
                  if(controller.app.user.value.jobTitle!=null)
                  TextX(
                    controller.app.user.value.jobTitle!,
                    style: TextStyleX.supTitleLarge,
                    fontWeight: FontWeight.w500,
                  ).marginOnly(top: 2),
                ],
              ).fadeAnimation100,
              const Spacer(),

              /// Notification
              InkResponse(
                onTap: controller.onNotifications,
                child: Stack(
                  children: [
                    /// Icon
                    ContainerX(
                      radius: 17,
                      height: 60,
                      width: 60,
                      borderWidth: 2,
                      borderColor: ColorX.grey.shade100,
                      isBorder: true,
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: Icon(
                          Iconsax.notification_bing,
                          color: ColorX.grey.shade500,
                        ),
                      ),
                    ),

                    /// Has New Notification Symbol
                    Obx(
                      () {
                        if (controller.isHasNewNotification.value) {
                          return Positioned(
                            top: 16,
                            right: 19,
                            child: ContainerX(
                              height: 10,
                              width: 10,
                              borderColor: Theme.of(context).cardColor,
                              isBorder: true,
                              borderWidth: 1,
                              color: const Color(0xffE7822F),
                              child: const SizedBox(),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ).fadeAnimation100,
            ],
          ),
        ],
      ),
    );
  }
}
