import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Data/Model/dashboard/task.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../widget.dart';

class TaskCardX extends StatelessWidget {
  const TaskCardX({super.key, required this.task, required this.onTap});
  final TaskX task;
  final Function(TaskX) onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await onTap(task),
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
                  TextX(
                    task.content,
                    maxLines: 2,
                    fontWeight: FontWeight.w700,
                  ).marginOnly(bottom: 10),
                  FittedBox(
                    child: Row(
                      children: [
                        TextX(
                          '${'The meeting'.tr}:',
                          style: TextStyleX.supTitleMedium,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        const SizedBox(width: 4),
                        TextX(
                          task.meeting?.title??'',
                          style: TextStyleX.supTitleMedium,
                        ),
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
