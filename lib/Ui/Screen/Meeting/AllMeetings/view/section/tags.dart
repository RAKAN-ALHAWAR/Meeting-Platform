import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Widget/widget.dart';
import '../../controller/controller.dart';

class TagsSectionForAllMeetings extends GetView<AllMeetingsController> {
  const TagsSectionForAllMeetings({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(
            right: StyleX.hPaddingApp-4,
            left: StyleX.hPaddingApp-4,
            top: StyleX.vPaddingApp,
            bottom: 10,
        ),
        child: Obx(
          () => Row(
            children: [
              for (int i = 0; i < controller.tags.length; i++)
                GestureDetector(
                  onTap: () => controller.onChangeTag(i),
                  child: ContainerX(
                    radius: 100,
                    isBorder: false,
                    color: controller.selectedTag.value==i?ColorX.primary:null,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 10,
                    ),
                    child: TextX(
                      controller.tags[i],
                      color: controller.selectedTag.value==i?Colors.white:ColorX.primary,
                      maxLines: 1,
                    ),
                  ).paddingSymmetric(horizontal: 4),
                ).fadeAnimation100,
            ],
          ),
        ),
      ),
    );
  }
}
