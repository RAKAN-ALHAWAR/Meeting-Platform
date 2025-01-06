import 'package:flutter/material.dart';
import '../../../../Config/config.dart';
import '../../widget.dart';

class CountdownCardX extends StatelessWidget {
  const CountdownCardX({
    super.key,
    required this.title,
    required this.countdown,
  });
  final String title;
  final int countdown;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContainerX(
          height: 55,
          width: 55,
          isBorder: false,
          padding: EdgeInsets.zero,
          child: Center(
            child: TextX(
              countdown.toString(),
              style: TextStyleX.titleLarge,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextX(
          title,
          style: TextStyleX.titleSmall,
          color: ColorX.grey.shade500,
        ),
      ],
    );
  }
}
