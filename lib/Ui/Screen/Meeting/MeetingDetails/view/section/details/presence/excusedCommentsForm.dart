import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../../../../Core/core.dart';
import '../../../../../../../Widget/widget.dart';
import '../../../../controller/controller.dart';

class ExcusedCommentFormPresenceStatus
    extends GetView<MeetingDetailsController> {
  const ExcusedCommentFormPresenceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    /// Input the excuse
    return Form(
      key: controller.formKeyPresenceStatus,
      autovalidateMode: controller.autoValidatePresenceStatus,
      child: TextFieldX(
        label: 'State the reason for not attending',
        controller: controller.excusedCommentsPresenceStatus,
        validate: ValidateX.excusedComments,
        minLines: 5,
      ),
    ).marginOnly(top: 10).fadeAnimation250;
  }
}
