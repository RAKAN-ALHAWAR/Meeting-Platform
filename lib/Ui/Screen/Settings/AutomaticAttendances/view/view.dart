import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/UI/Widget/widget.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../controller/controller.dart';

class AutomaticAttendancesView extends GetView<AutomaticAttendancesController> {
  const AutomaticAttendancesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Automatic attendances'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: StyleX.vPaddingApp,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: controller.onChangeAutomaticPreparation,
              child: ContainerX(
                radius: StyleX.radiusMd,
                padding: const EdgeInsetsDirectional.only(
                  start: 14.0,
                  end: 8,
                  top: 20,
                  bottom: 20,
                ).resolve(Directionality.of(context)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextX('Enable automatic preparation'),
                          const SizedBox(height: 4),
                          TextX(
                            'When activated, your attendance will be automatically activated for any meeting you are invited to, with the possibility of deactivating it at any time',
                            style: TextStyleX.supTitleLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Obx(
                          () => SwitchX(
                        margin: EdgeInsets.zero,
                        value: controller.automaticPreparation.value,
                        onChange: (_) async => await controller.onChangeAutomaticPreparation(),
                      ),
                    )
                  ],
                ),
              ),
            ).fadeAnimation200,
          ],
        ),
      ),
    );
  }
}
