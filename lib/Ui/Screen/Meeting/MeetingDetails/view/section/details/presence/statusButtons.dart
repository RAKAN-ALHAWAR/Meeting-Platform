import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../../Config/config.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../controller/controller.dart';

class StatusButtonsPresenceStatus extends GetView<MeetingDetailsController> {
  const StatusButtonsPresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    /// Titles
    List<String> presenceStatus = [
      'I will attend',
      'I will not attend',
      'Power of attorney'
    ];

    /// Icons
    List<IconData> presenceIcons = [
      Icons.check_rounded,
      Icons.close_rounded,
      Iconsax.profile_2user
    ];

    /// Colors
    List<Color> presenceIconColors = [
      ColorX.green.shade500,
      ColorX.red.shade600,
      ColorX.yellow.shade500
    ];
    List<Color> selectedColors = [
      ColorX.primary,
      ColorX.red.shade600,
      ColorX.yellow.shade400
    ];

    /// Content
    return Obx(
      () {
        return Row(
          children: [
            for (int i = 0; i < presenceStatus.length; i++)

              /// Buttons
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.onChangePresenceStatusSelected(i),
                  child: ContainerX(
                    height: 45,
                    radius: 8,
                    padding: EdgeInsets.zero,
                    isBorder: false,
                    margin: EdgeInsetsDirectional.only(
                      end: i != presenceStatus.length - 1 ? 8 : 0,
                    ),
                    color: controller.selectedPresenceStatus.value == i
                        ? selectedColors[i]
                        : ColorX.grey.shade50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Icon
                        Icon(
                          presenceIcons[i],
                          size: i != presenceStatus.length - 1 ? 23 : 18,
                          color: controller.selectedPresenceStatus.value == i
                              ? Colors.white
                              : presenceIconColors[i],
                        ),
                        const SizedBox(width: 4),

                        /// Title
                        TextX(
                          presenceStatus[i],
                          maxLines: 1,
                          size: 13,
                          color: controller.selectedPresenceStatus.value == i
                              ? Colors.white
                              : null,
                          fontWeight:
                              controller.selectedPresenceStatus.value == i
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ).fadeAnimation250,
              ),
          ],
        );
      },
    );
  }
}
