import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../widget.dart';

class FileWithDeleteCardX extends StatelessWidget {
  const FileWithDeleteCardX({
    super.key,
    required this.file,
    required this.name,
    required this.size,
    required this.onDelete,
  });
  final File file;
  final String name;
  final String size;
  final Function(File) onDelete;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      height: 70,
      padding: const EdgeInsets.all(12),
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
                  child: FunctionX.isImage(name.split('.').last.toLowerCase())
                      ? ImageNetworkX(
                          imageUrl: file.path,
                          isFile: true,
                          height: 40,
                          width: 40,
                          radius: 8,
                        )
                      : Center(
                          child: Icon(
                            IconsaxPlusLinear.document_text_1,
                            color: ColorX.grey.shade400,
                            size: 30,
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextX(
                          name,
                          maxLines: 1,
                        ),
                      ),
                      TextX(
                        size,
                        style: TextStyleX.supTitleLarge,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkResponse(
            onTap: () async => await onDelete(file),
            child: Icon(
              Iconsax.trash,
              color: ColorX.danger.shade500,
            ).paddingAll(4),
          )
        ],
      ),
    );
  }
}
