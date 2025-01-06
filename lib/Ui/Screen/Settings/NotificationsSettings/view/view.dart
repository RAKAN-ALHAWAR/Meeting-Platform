import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Other/optionCard.dart';

import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';

class NotificationsSettingsView
    extends GetView<NotificationsSettingsController> {
  const NotificationsSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Notification settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: StyleX.vPaddingApp,
        ),
        child: Column(
          children: [
            OptionCardX(
              title: 'App notifications',
              onTap: controller.onChangeAppNotifications,
              child: Obx(
                () => SwitchX(
                  value: controller.appNotifications.value,
                  onChange: (_) async =>
                      await controller.onChangeAppNotifications(),
                ),
              ),
            ).fadeAnimation150,
            OptionCardX(
              title: 'Email notifications',
              onTap: controller.onChangeEmailNotifications,
              child: Obx(
                () => SwitchX(
                  value: controller.emailNotifications.value,
                  onChange: (_) async =>
                      await controller.onChangeEmailNotifications(),
                ),
              ),
            ).fadeAnimation200,

            OptionCardX(
              title: 'WhatsApp notifications',
              onTap: controller.onChangeWhatsappNotifications,
              child: Obx(
                    () => SwitchX(
                  value: controller.whatsappNotifications.value,
                  onChange: (_) async =>
                  await controller.onChangeWhatsappNotifications(),
                ),
              ),
            ).fadeAnimation250,
            OptionCardX(
              title: 'SMS notifications',
              onTap: controller.onChangeSmsNotifications,
              child: Obx(
                () => SwitchX(
                  value: controller.smsNotifications.value,
                  onChange: (_) async =>
                      await controller.onChangeSmsNotifications(),
                ),
              ),
            ).fadeAnimation300,
            OptionCardX(
              title: 'Google Calendar notifications',
              onTap: controller.onChangeGoogleCalenderNotifications,
              child: Obx(
                () => SwitchX(
                  value: controller.googleCalenderNotifications.value,
                  onChange: (_) async =>
                      await controller.onChangeGoogleCalenderNotifications(),
                ),
              ),
            ).fadeAnimation350,
          ],
        ),
      ),
    );
  }
}
