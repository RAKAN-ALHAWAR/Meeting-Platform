import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:meeting/Data/Model/attachment/attachment.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../widget.dart';

class AttachmentCardX extends StatelessWidget {
  const AttachmentCardX({
    super.key,
    required this.attachment,
    required this.url,
    required this.onTap,
  });
  final AttachmentX attachment;
  final String url;
  final Function(AttachmentX) onTap;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () async => await onTap(attachment),
      child: ContainerX(
        height: 124,
        width: 140,
        radius: StyleX.radiusLg,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        color: ColorX.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerX(
              radius: 12,
              padding: EdgeInsets.zero,
              height: 60,
              width: 60,
              child: FunctionX.isImage(attachment.type)
                  ? ImageNetworkX(
                      imageUrl: url,
                      height: 45,
                      width: 45,
                      radius: 12,
                      fit: BoxFit.cover,
                      empty: Center(
                        child: Icon(
                          IconsaxPlusLinear.document_text_1,
                          color: ColorX.grey.shade400,
                          size: 30,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        IconsaxPlusLinear.document_text_1,
                        color: ColorX.grey.shade400,
                        size: 30,
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: TextX(
                '${attachment.name}.${attachment.type}',
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
