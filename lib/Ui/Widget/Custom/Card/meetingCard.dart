import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:meeting/Config/Translation/translation.dart';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Data/Model/meeting/meeting.dart';
import 'package:meeting/Ui/Widget/Custom/Other/meetingState.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../widget.dart';

class MeetingCardX extends StatelessWidget {
  const MeetingCardX({super.key, required this.meeting, required this.onTap});
  final MeetingX meeting;
  final Function(MeetingX) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async=>await onTap(meeting),
      child: ContainerX(
        radius: StyleX.radiusLg,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        isBorder: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MeetingStateX(meeting: meeting),
                  TextX(
                    meeting.title,
                    maxLines: 2,
                    fontWeight: FontWeight.w700,
                  ).marginSymmetric(vertical: 10),
                  FittedBox(
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.calendar_1,
                          color: ColorX.grey.shade400,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        TextX(
                            DateFormat('EEEE, d MMMM yyyy',
                                    TranslationX.getLanguageCode)
                                .format(meeting.date),
                            style: TextStyleX.supTitleMedium),
                        const SizedBox(width: 12),
                        Icon(
                          Iconsax.clock,
                          color: ColorX.grey.shade400,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        TextX(
                            '${DateFormat('hh:mm a', TranslationX.getLanguageCode).format(meeting.startAt.toDateTimeX)} - ${DateFormat('hh:mm a', TranslationX.getLanguageCode).format(meeting.endAt.toDateTimeX)}',
                            style: TextStyleX.supTitleMedium),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              margin: EdgeInsets.only(
                left: DeviseX.isLTR ? 24 : 0,
                right: DeviseX.isLTR ? 0 : 24,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorX.grey.shade500,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
