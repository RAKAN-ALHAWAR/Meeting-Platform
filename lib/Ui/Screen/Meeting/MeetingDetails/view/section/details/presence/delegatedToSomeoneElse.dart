import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../../../../Config/config.dart';
import '../../../../../../../../UI/Widget/widget.dart';
import '../../../../../../../Widget/Custom/Other/delegateState.dart';
import '../../../../controller/controller.dart';

class DelegatedToSomeoneElsePresenceStatus
    extends GetView<MeetingDetailsController> {
  const DelegatedToSomeoneElsePresenceStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Message
          MessageCardX(
            color: ColorX.yellow,
            icon: Iconsax.profile_2user,
            text: controller.isClosedMeeting.value
                ? 'Someone else has been delegated for this meeting'
                : 'Delegate to another person',
          ).fadeAnimation250,

          /// My Delegate Details
          if (controller.myDelegate.value != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Delegate name
                if (controller.myDelegate.value?.delegated != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Title
                      TextX(
                        'Delegate name',
                        color: ColorX.grey.shade500,
                        style: TextStyleX.titleSmall,
                      ),

                      /// Name
                      TextX(controller.myDelegate.value?.delegated?.name ?? ''),
                    ],
                  ).fadeAnimation300,

                /// Delegate status
                if (controller.isClosedMeeting.isFalse)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Title
                      TextX(
                        'Delegate status',
                        color: ColorX.grey.shade500,
                        style: TextStyleX.titleSmall,
                      ),

                      /// Status
                      DelegateStateX(
                        status: controller.myDelegate.value!.status,
                      ),
                    ],
                  ).marginOnly(top: 14).fadeAnimation350,
              ],
            ).marginOnly(top: 16),
        ],
      ),
    );
  }
}
