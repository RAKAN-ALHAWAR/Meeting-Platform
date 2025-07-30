import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../Config/config.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../controller/controller.dart';

class HeaderPresenceStatus extends GetView<MeetingDetailsController> {
  const HeaderPresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Title
          const TextX(
            'Your presence status',
            fontWeight: FontWeight.w700,
          ),

          /// Edit Button
          if (controller.isShowButtonEditPresenceStatus.isTrue)
            InkResponse(
              onTap: controller.onTapEditPresenceStatus,
              child: Icon(
                IconsaxPlusLinear.edit_2,
                color: ColorX.grey.shade500,
                size: 22,
              ),
            ),
        ],
      ).marginOnly(bottom: 12).fadeAnimation250,
    );
  }
}
