import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Core/core.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Basic/Utils/future_builder.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Section/generalStatistics.dart';
import '../../../../Widget/Custom/Other/optionCard.dart';
import '../controller/controller.dart';
import 'section/loading.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilderX(
        future: controller.getData,
        loading: const LoadingForProfileDetails(),
        child: (_) => SingleChildScrollView(
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
            vertical: StyleX.vPaddingApp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Profile Image
                  ContainerX(
                    radius: 22,
                    height: 86,
                    width: 86,
                    borderWidth: 4,
                    borderColor: Get.theme.cardColor,
                    isBorder: true,
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Obx(
                          () => ImageNetworkX(
                            /// تحديث الصورة عند تغييرها
                            key: Key(
                              controller.app.user.value.imageUrl ??
                                  "profile image",
                            ),
                            height: 82,
                            width: 82,
                            imageUrl:
                                controller.app.user.value.imageUrl ?? "",
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
                                  : Icon(
                                      Icons.account_circle_rounded,
                                      color: ColorX.primary,
                                      size: 50,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).fadeAnimation100,

                  const SizedBox(
                    height: 8,
                    width: double.infinity,
                  ),

                  /// Name & Job Title
                  GetBuilder<AppControllerX>(
                    builder: (controller) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextX(
                          key: Key(controller.user.value.name),
                          controller.user.value.name,
                          style: TextStyleX.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        if (controller.user.value.jobTitle != null)
                          TextX(
                            controller.user.value.jobTitle!,
                            style: TextStyleX.supTitleLarge,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ).marginOnly(top: 2),
                      ],
                    ).fadeAnimation100,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// Statistics Card
              GeneralStatisticsSectionX(
                statistics: controller.statistics,
              ).fadeAnimation150,
              const SizedBox(height: 24),

              TextX(
                'My account',
                color: ColorX.primary.shade700,
                fontWeight: FontWeight.w700,
              ).fadeAnimation150.marginOnly(bottom: 10),

              /// Edit Profile
              OptionCardX(
                title: 'My personal data',
                icon: IconsaxPlusLinear.profile,
                onTap: controller.onEditProfile,
              ).fadeAnimation200,

              /// Change password
              OptionCardX(
                title: 'Change password',
                icon: Iconsax.lock,
                onTap: controller.onChangePassword,
              ).fadeAnimation200,

              /// Automatic attendances
              OptionCardX(
                title: 'Automatic attendances',
                icon: Iconsax.toggle_off_circle,
                onTap: controller.onAutomaticAttendances,
              ).fadeAnimation250,

              /// My signatures
              OptionCardX(
                title: 'My signatures',
                icon: IconX.signatures,
                onTap: controller.onMySignatures,
              ).fadeAnimation250,

              TextX(
                'Settings',
                color: ColorX.primary.shade700,
                fontWeight: FontWeight.w700,
              ).fadeAnimation300.marginSymmetric(vertical: 10),

              /// Application language
              OptionCardX(
                title: 'Application language',
                icon: Iconsax.global,
                onTap: controller.onApplicationLanguage,
                child: Row(
                  children: [
                    Obx(
                      () => TextX(
                        controller.languageName.value,
                        style: TextStyleX.supTitleLarge,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorX.grey.shade500,
                      size: 16,
                    )
                  ],
                ),
              ).fadeAnimation300,

              /// Notification settings
              OptionCardX(
                title: 'Notification settings',
                icon: Iconsax.notification_bing,
                onTap: controller.onNotificationsSettings,
              ).fadeAnimation350,

              TextX(
                'Other',
                color: ColorX.primary.shade700,
                fontWeight: FontWeight.w700,
              ).fadeAnimation350.marginSymmetric(vertical: 10),

              /// My suggestions
              OptionCardX(
                title: 'My suggestions',
                icon: Iconsax.receipt_edit,
                onTap: controller.onMySuggestions,
              ).fadeAnimation400,

              /// Logout
              OptionCardX(
                title: 'Logout',
                icon: Iconsax.logout,
                onTap: () => bottomSheetDangerousX(
                  title: "Logout",
                  message: "Are you sure you want to log out?",
                  okText: "Logout",
                  cancelText: "Stay",
                  icon: Icons.warning_rounded,
                  onOk: controller.app.logOut,
                ),
              ).fadeAnimation400,
            ],
          ),
        ),
      ),
    );
  }
}
