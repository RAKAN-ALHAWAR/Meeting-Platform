import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Config/config.dart';
import '../../../../../../UI/Animation/animation.dart';

class LoadingForProfileDetails extends StatelessWidget {
  const LoadingForProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
        vertical: StyleX.vPaddingApp,
      ),
      child: Column(
        children: [
          ShimmerAnimationX(
            height: 86,
            width: 86,
            borderRadius: BorderRadius.circular(22),
            margin: const EdgeInsets.only(bottom: 14),
          ),
          const ShimmerAnimationX(
            height: 20,
            width: 100,
            margin: EdgeInsets.only(bottom: 6),
          ),
          const ShimmerAnimationX(
            height: 14,
            width: 60,
            margin: EdgeInsets.only(bottom: 24),
          ),
          const Row(
            children: [
              Expanded(
                child: ShimmerAnimationX(
                  height: 160,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ShimmerAnimationX(
                  height: 160,
                ),
              ),
            ],
          ).marginOnly(bottom: 24),
          for (int i = 0; i < 8; i++)
            const ShimmerAnimationX(
              height: 70,
              margin: EdgeInsets.only(bottom: 10),
            )
        ],
      ),
    );
  }
}
