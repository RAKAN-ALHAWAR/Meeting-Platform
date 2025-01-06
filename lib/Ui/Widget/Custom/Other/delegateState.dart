import 'package:flutter/material.dart';
import 'package:meeting/Data/Enum/delegate_status_status.dart';
import '../../../../Config/config.dart';
import '../../widget.dart';

class DelegateStateX extends StatelessWidget {
  const DelegateStateX({super.key, required this.status});
  final DelegateStatusStatusX status;
  @override
  Widget build(BuildContext context) {
    MaterialColor color = status==DelegateStatusStatusX.accepted?ColorX.green:status==DelegateStatusStatusX.rejected?ColorX.red:ColorX.yellow;
    return ContainerX(
      isBorder: true,
      color: color.shade50,
      borderColor: color.shade300,
      radius: 100,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      child: TextX(
        status.name,
        style: TextStyleX.supTitleLarge,
        color: color.shade500,
      ),
    );
  }
}
