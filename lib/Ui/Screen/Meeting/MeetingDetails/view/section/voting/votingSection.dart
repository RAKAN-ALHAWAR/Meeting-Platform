import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../../UI/Widget/widget.dart';
import '../../../controller/controller.dart';
import 'previousVote.dart';
import 'votingEnded.dart';
import 'voteForm/voteForm.dart';
import 'votingStartAt.dart';

class VotingSection extends GetView<MeetingDetailsController> {
  const VotingSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        TextX(
          'Voting',
          style: TextStyleX.titleLarge,
          size: 16,
        ).fadeAnimation200,
        const SizedBox(height: 6),

        /// Content
        Obx(
          () {
            if (controller.isOpenVoting.isFalse &&
                controller.isEndVoting.isFalse) {
              /// If voting has not started yet
              return const VotingStartAt();
            } else if (controller.isEndVoting.isTrue &&
                controller.isVoted.isFalse) {
              /// If the voting has ended
              return const VotingEnded();
            } else if (controller.isVoted.isTrue) {
              /// Previous Vote
              return const PreviousVote();
            } else {
              /// Enter vote
              return const VoteForm();
            }
          },
        ),
      ],
    );
  }
}
