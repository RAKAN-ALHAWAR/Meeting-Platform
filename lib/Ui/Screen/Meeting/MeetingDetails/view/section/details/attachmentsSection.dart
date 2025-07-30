import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/UI/Widget/widget.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../Widget/Custom/Card/attachmentHorizontalCard.dart';
import '../../../controller/controller.dart';

class AttachmentsSection extends GetView<MeetingDetailsController> {
  const AttachmentsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      width: double.maxFinite,
      padding: const EdgeInsets.only(right: 14, left: 14, top: 14, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          const TextX(
            'Meeting attachments',
            fontWeight: FontWeight.w700,
          ).fadeAnimation400,

          /// Space
          const SizedBox(height: 16),

          /// Files Card
          for (int i = 0; i < controller.meeting.value.attachments.length; i++)
            AttachmentHorizontalCardX(
              attachment: controller.meeting.value.attachments[i],
              onTap: controller.onTapAttachment,
              size: controller.fileSizes[i],
              url: controller.getAttachmentUrl(
                controller.meeting.value.attachments[i],
              ),
            ).fadeAnimation450
        ],
      ),
    ).fadeAnimation350;
  }
}
