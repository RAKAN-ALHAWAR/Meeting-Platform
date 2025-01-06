import 'package:flutter/material.dart';

import '../../../../../../../Config/config.dart';
import '../../../../../../../UI/Animation/animation.dart';

class LoadingSectionForMeetingDetails extends StatelessWidget {
  const LoadingSectionForMeetingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: StyleX.paddingApp,
      child: Column(
        children: [
          ShimmerAnimationX(height: 186),
          SizedBox(height: 16),
          ShimmerAnimationX(height: 50),
          SizedBox(height: 16),
          ShimmerAnimationX(height: 100),
          SizedBox(height: 16),
          ShimmerAnimationX(height: 410),
          SizedBox(height: 16),
          ShimmerAnimationX(height: 120),
        ],
      ),
    );
  }
}
