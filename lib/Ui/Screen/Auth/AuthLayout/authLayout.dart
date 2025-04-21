import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../Config/config.dart';
import '../../../../UI/Widget/widget.dart';

class AuthLayoutX extends StatelessWidget {
  const AuthLayoutX({
    super.key,
    required this.child,
    this.isBackIcon = true,
    this.isShowLogo = true,
    required this.title,
    required this.subtitle,
  });
  final Widget child;
  final bool isBackIcon;
  final bool isShowLogo;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: !isShowLogo,
      backgroundColor: Get.theme.cardColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const SizedBox(height: double.infinity),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(gradient: ColorX.primaryGradient),
            child: SafeArea(
              child: Center(
                child: Image.asset(
                  ImageX.logoWhite,
                  width: 180,
                ).fadeAnimation100,
              ),
            ),
          ),
          Positioned.fill(
            top: -StyleX.radiusXLg,
            child: SingleChildScrollView(
              child: ContainerX(
                width: double.infinity,
                color: Get.theme.cardColor,
                isBorder: false,
                padding: const EdgeInsets.only(
                  top: 25,
                  left: StyleX.hPaddingApp,
                  right: StyleX.hPaddingApp,
                ),
                margin: const EdgeInsets.only(top: 300),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(StyleX.radiusXLg),
                ),
                child: SafeArea(
                  top: false,
                  right: false,
                  left: false,
                  child: Column(
                    children: [
                      /// Title
                      TextX(
                        title,
                        style: TextStyleX.headerMedium,
                        color: Theme.of(context).primaryColor,
                      ).marginOnly(bottom: 8).fadeAnimation200,

                      /// Subtitle
                      TextX(
                        subtitle,
                        color: Theme.of(context).colorScheme.secondary,
                        textAlign: TextAlign.center,
                      ).marginOnly(bottom: 28).fadeAnimation200,

                      Container(
                          constraints: BoxConstraints(maxWidth: 700),
                          child: child,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isShowLogo)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageX.sponsorLogo,
                      width: 50,
                    ).fadeAnimation600,
                  ],
                ),
              ),
            ),
          if (isBackIcon)
            Positioned.directional(
              textDirection: Directionality.of(context),
              start: 0,
              top: 6,
              child: SafeArea(
                child: const BackButtonX(
                  color: Colors.white,
                  background: Colors.white10,
                ).fadeAnimation100,
              ),
            ),
        ],
      ),
    );
  }
}
