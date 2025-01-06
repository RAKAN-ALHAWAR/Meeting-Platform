import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../../../UI/Widget/widget.dart';

class OptionCardX extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function()? onTap;
  final bool isDanger;
  final Widget? child;

  const OptionCardX({
    required this.title,
    this.icon,
    this.onTap,
    this.child,
    this.isDanger = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerX(
        radius: StyleX.radiusMd,
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
        child: Row(
          children: [
            if(icon!=null)
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(
                  right: DeviseX.isLTR ? 15.0 : 0.0,
                  left: DeviseX.isLTR ? 0 : 19),
              decoration: BoxDecoration(
                color: isDanger ? ColorX.danger : ColorX.primary.shade50,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: context.isDarkMode
                      ? ColorX.primary.shade200
                      : ColorX.primary.shade700,
                  size: 24,
                ),
              ),
            ),
            Expanded(
              child: TextX(
                title,
                color: isDanger ? ColorX.danger : null,
              ),
            ),
            child != null
                ? child!
                : Container(
                    margin: EdgeInsets.only(
                      left: DeviseX.isLTR ? 24 : 0,
                      right: DeviseX.isLTR ? 0 : 24,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color:
                          isDanger ? ColorX.danger : ColorX.grey.shade500,
                      size: 16,
                    ),
                  ),
          ],
        ),
      ),
    ).marginOnly(bottom: 8);
  }
}
