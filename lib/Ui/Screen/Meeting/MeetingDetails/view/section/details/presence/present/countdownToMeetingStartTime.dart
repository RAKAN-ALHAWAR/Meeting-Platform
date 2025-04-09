import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Widget/Custom/Card/countdownCard.dart';
import '../../../../../../../../../Config/config.dart';
import '../../../../../../../../../UI/Widget/widget.dart';
import '../../../../../controller/controller.dart';

class CountdownToMeetingStartTime extends GetView<MeetingDetailsController> {
  const CountdownToMeetingStartTime({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ContainerX(
            color: ColorX.grey.shade50,
            radius: StyleX.radiusMd,
            isBorder: false,
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Title
                TextX(
                  'The meeting will start after',
                  color: ColorX.primary.shade700,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 16),

                /// Countdown Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Days
                    CountdownCardX(
                      title: 'Day',
                      countdown: controller.days.value,
                    ),
                    const SizedBox(
                      height: 55,
                      child: Center(child: TextX(" : ")),
                    ),

                    /// Hours
                    CountdownCardX(
                      title: 'Hour',
                      countdown: controller.hours.value,
                    ),
                    const SizedBox(
                      height: 55,
                      child: Center(child: TextX(" : ")),
                    ),

                    /// Minutes
                    CountdownCardX(
                      title: 'Minute',
                      countdown: controller.minutes.value,
                    ),
                    const SizedBox(
                      height: 55,
                      child: Center(child: TextX(" : ")),
                    ),

                    /// Seconds
                    CountdownCardX(
                      title: 'Second',
                      countdown: controller.seconds.value,
                    ),
                  ],
                ),

                /// Note of meeting link
                if (controller.meeting.value.locationOnlineUrl != null &&
                    !controller.isShowMeetingLink.value)
                  const TextX(
                    'The meeting link will be displayed one hour before the meeting',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    size: 13,
                  ).marginOnly(top: 12),
              ],
            ),
          ),
          /// Show Meeting Link if less than or equal to 1 hour remaining
          if (controller.meeting.value.locationOnlineUrl != null &&
              controller.isShowMeetingLink.value)
            ContainerX(
              color: ColorX.grey.shade50,
              radius: StyleX.radiusMd,
              isBorder: false,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(16),
              width: double.maxFinite,
              child: Column(
                children: [
                  TextX(
                    "Meeting link",
                    textAlign: TextAlign.center,
                    style: TextStyleX.titleMedium,
                    color: ColorX.primary,
                  ),
                  SizedBox(height: 6),
                  TextX(
                    controller.meeting.value.locationOnlineUrl ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyleX.supTitleMedium,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
