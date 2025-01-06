import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Config/config.dart';
import '../../Data/Model/dashboard/statistics.dart';
import '../Widget/widget.dart';

class GeneralStatisticsSectionX extends StatelessWidget {
  const GeneralStatisticsSectionX({
    super.key,
    required this.statistics,
  });
  final StatisticsX statistics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ContainerX(
            color: ColorX.green.shade50,
            borderColor: ColorX.green.shade200,
            isBorder: true,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            radius: StyleX.radiusLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Iconsax.people,
                  color: ColorX.green.shade500,
                  size: 30,
                ).marginSymmetric(vertical: 14),
                const FittedBox(
                  child: TextX(
                    'Number of meetings',
                    size: 16,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 2),
                TextX(
                  statistics.meetingCount.toString(),
                  style: TextStyleX.headerSmall,
                  color: ColorX.green.shade500,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ContainerX(
            color: ColorX.blue.shade50,
            borderColor: ColorX.blue.shade200,
            isBorder: true,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            radius: StyleX.radiusLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Iconsax.people,
                  color: ColorX.blue.shade500,
                  size: 30,
                ).marginSymmetric(vertical: 14),
                const FittedBox(
                  child: TextX(
                    'Upcoming meetings',
                    size: 16,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 2),
                TextX(
                  statistics.newMeetingCount.toString(),
                  style: TextStyleX.headerSmall,
                  color: ColorX.blue.shade500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
