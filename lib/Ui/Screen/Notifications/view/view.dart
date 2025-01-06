import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Basic/Utils/future_builder.dart';
import '../../../../../Config/config.dart';
import '../../../../UI/Animation/animation.dart';
import '../../../Section/GeneralState/empty.dart';
import '../../../Widget/widget.dart';
import '../controller/controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Notifications'),
      body: SafeArea(
        child: FutureBuilderX(
          future: controller.getData,
          loading: SingleChildScrollView(
            padding: StyleX.paddingApp,
            child: Column(
              children: [
                for (int i = 0; i < 10; i++)
                  const ShimmerAnimationX(
                    height: 111,
                    margin: EdgeInsets.only(bottom: 12),
                  )
              ],
            ),
          ),
          child: (data) => Obx(
            () {
              /// Empty State
              if (controller.notifications.isEmpty) {
                return const EmptyView(
                  message: "You have no new notifications.",
                ).fadeAnimation200;
              } else {
                /// Main Content
                return ListView.builder(
                  padding: StyleX.paddingApp,
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                      notification: controller.notifications[index],
                    ).fadeAnimation200;
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
