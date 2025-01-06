import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../../../Data/Model/attachment/attachment.dart';
import '../../widget.dart';

class AttachmentHorizontalCardX extends StatelessWidget {
  const AttachmentHorizontalCardX({
    super.key,
    required this.attachment,
    required this.size,
    required this.url,
    required this.onTap,
  });
  final AttachmentX attachment;
  final String size;
  final String url;
  final Function(AttachmentX) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await onTap(attachment),
      child: ContainerX(
        height: 74,
        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 12),
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ContainerX(
                    radius: 8,
                    padding: EdgeInsets.zero,
                    height: 40,
                    width: 40,
                    color: ColorX.grey.shade50,
                    child: FunctionX.isImage(attachment.type)
                        ? ImageNetworkX(
                            imageUrl: url,
                            height: 40,
                            width: 40,
                            radius: 8,
                            fit: BoxFit.cover,
                            empty: Center(
                              child: Icon(
                                IconsaxPlusLinear.document_text_1,
                                color: ColorX.grey.shade400,
                                size: 22,
                              ),
                            ),
                          )
                        : Center(
                            child: Icon(
                              IconsaxPlusLinear.document_text_1,
                              color: ColorX.grey.shade400,
                              size: 22,
                            ),
                          ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextX(
                            '${attachment.name}.${attachment.type}',
                            maxLines: 1,
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextX(
                            size,
                            style: TextStyleX.supTitleLarge,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.all(4),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorX.grey.shade500,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
