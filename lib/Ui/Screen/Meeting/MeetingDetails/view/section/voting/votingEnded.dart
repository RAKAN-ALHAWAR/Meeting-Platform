import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Custom/Card/messageCard.dart';
import '../../../../../../../Config/config.dart';
import '../../../controller/controller.dart';

class VotingEnded extends GetView<MeetingDetailsController> {
  const VotingEnded({super.key});

  @override
  Widget build(BuildContext context) {
    /// Voting ended message
    return const MessageCardX(
      text: 'Voting on the meeting has ended',
      color: ColorX.red,
      icon: Iconsax.danger,
    ).fadeAnimation250;
  }
}
