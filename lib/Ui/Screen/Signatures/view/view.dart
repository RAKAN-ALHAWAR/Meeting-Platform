import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/widget.dart';

import '../controller/controller.dart';

class SignaturesView extends GetView<SignaturesController> {
  const SignaturesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'My signatures'),
      body: SafeArea(
        child: Obx(
          () {
            print( controller.signature.value);
            if (controller.signature.value != null) {
              /// Show Signature
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: StyleX.hPaddingApp,
                  vertical: StyleX.vPaddingApp,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        /// Signature image
                        ContainerX(
                          height: 134,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 8),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: ImageNetworkX(
                              imageUrl: controller.signature.value!,
                              height: 80,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        /// Delete Icon
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          top: 8,
                          end: 8,
                          child: InkResponse(
                            onTap: controller.onDeleteSignature,
                            child: Icon(
                              Iconsax.trash,
                              color: ColorX.danger.shade500,
                            ).paddingAll(8),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              /// Empty State & Add Signature Button
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconX.signatures,
                    color: ColorX.grey.shade300,
                    size: 70,
                  ).fadeAnimation100,
                  const SizedBox(height: 18),
                  TextX(
                    'You have not added any signature yet',
                    style: TextStyleX.titleLarge,
                  ).fadeAnimation150,
                  const SizedBox(height: 12, width: double.infinity),
                  ButtonX(
                    text: 'Add signature',
                    onTap: controller.onAddSignature,
                    width: 170,
                  ).fadeAnimation200,
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
