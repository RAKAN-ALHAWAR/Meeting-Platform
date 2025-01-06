import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meeting/UI/Widget/widget.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Basic/Utils/future_builder.dart';
import 'package:meeting/Ui/Widget/Custom/Card/attachmentCard.dart';

import '../../../../../Config/Translation/translation.dart';
import '../../../../../Config/config.dart';
import '../../../../../UI/Animation/animation.dart';
import '../controller/controller.dart';

class SuggestionDetailsView extends GetView<SuggestionDetailsController> {
  const SuggestionDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'My suggestions'),
      body: SafeArea(
        child: FutureBuilderX(
          future: controller.getData,
          loading: const Padding(
            padding: StyleX.paddingApp,
            child: ShimmerAnimationX(
              height: 240,
            ),
          ),
          child: (suggestion) => SingleChildScrollView(
            padding: StyleX.paddingApp,
            child: ContainerX(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                  ).fadeAnimation100,
                  const SizedBox(height: 14),
                  TextX(
                    DateFormat(
                      'EEEE h:mm a, d MMMM yyyy',
                      TranslationX.getLanguageCode,
                    ).format(suggestion.createdAt),
                    style: TextStyleX.supTitleMedium,
                    size: 15,
                  ).fadeAnimation150,
                  const SizedBox(height: 14),
                  if (suggestion.title != null)
                    TextX(
                      suggestion.title!,
                      maxLines: 1,
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ).fadeAnimation200,
                  if (suggestion.title != null) const SizedBox(height: 14),
                  TextX(
                    suggestion.message,
                    style: TextStyleX.titleSmall,
                    color: ColorX.grey.shade800,
                  ).fadeAnimation200,
                  if (suggestion.attachments.isNotEmpty)
                    const SizedBox(height: 18),
                  if (suggestion.attachments.isNotEmpty)
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var attachment in suggestion.attachments)
                          AttachmentCardX(
                            attachment: attachment,
                            url: controller.getUrl(attachment),
                            onTap: controller.onTapAttachment,
                          ).fadeAnimation200,
                      ],
                    ),
                  if (suggestion.replyMessage != null)
                    ContainerX(
                      color: ColorX.green.shade100,
                      margin: const EdgeInsets.only(top: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextX(
                                "Administrator's response",
                                color: ColorX.green.shade600,
                                fontWeight: FontWeight.w400,
                              ).fadeAnimation250,
                              if (suggestion.readAt != null)
                                TextX(
                                  DateFormat(
                                    'd MMMM yyyy',
                                    TranslationX.getLanguageCode,
                                  ).format(suggestion.readAt!),
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                ).fadeAnimation250,
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextX(
                            suggestion.replyMessage!,
                            fontWeight: FontWeight.w400,
                          ).fadeAnimation250,
                        ],
                      ),
                    ).fadeAnimation200,
                ],
              ),
            ).fadeAnimation100,
          ),
        ),
      ),
    );
  }
}
