import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meeting/Config/Translation/translation.dart';

import '../../../../Config/config.dart';
import '../../../../Data/Model/suggestion/suggestion.dart';
import '../../widget.dart';

class SuggestionCardX extends StatelessWidget {
  const SuggestionCardX(
      {super.key, required this.suggestion, required this.onTap});
  final SuggestionX suggestion;
  final Function(SuggestionX) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await onTap(suggestion),
      child: ContainerX(
        radius: StyleX.radiusLg,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        isBorder: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerX(
              isBorder: true,
              color: suggestion.replyMessage != null
                  ? ColorX.green.shade50
                  : ColorX.yellow.shade50,
              borderColor: suggestion.replyMessage != null
                  ? ColorX.green.shade300
                  : ColorX.yellow.shade300,
              radius: 100,
              padding:
                  const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
              child: TextX(
                suggestion.replyMessage != null ? 'Replied' : 'Pending',
                style: TextStyleX.supTitleLarge,
                color: suggestion.replyMessage != null
                    ? ColorX.green.shade500
                    : ColorX.yellow.shade500,
              ),
            ),
            TextX(
              suggestion.title??suggestion.message,
              maxLines: 1,
              size: 16,
              fontWeight: FontWeight.w600,
            ).marginSymmetric(vertical: 10),
            FittedBox(
              child: Row(
                children: [
                  TextX(
                    '${'Date added'.tr}: ',
                    style: TextStyleX.supTitleMedium,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  TextX(
                    DateFormat('EEEE h:mm a, d MMMM yyyy', TranslationX.getLanguageCode)
                        .format(suggestion.createdAt),
                    style: TextStyleX.supTitleMedium,
                    size: 14,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
