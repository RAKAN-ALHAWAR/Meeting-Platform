import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../../Config/config.dart';
import '../../../Widget/widget.dart';
import '../controller/controller.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// for don't move navbar when open keyboard
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Obx(
        () => Scaffold(
          /// App Bar
          appBar: controller.isHomePage()?null:AppBarRootX(
            key: Key(controller.pages[controller.indexPageSelected.value].label),
            title: controller.pages[controller.indexPageSelected.value].label,
            pages: controller.pages,
            indexSelected: controller.indexPageSelected.value,
            leadingWidth: 100,
            leading: BackButtonX(onTap: controller.openHome).fadeAnimation100,
          ),

          /// Pages Content
          body: controller.pages[controller.indexPageSelected.value].view,

          /// Nav Bar
          bottomNavigationBar:  ContainerX(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            isShadow: true,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,

            /// To add some safety space on the edges so that the titles do not come off the screen
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: SizedBox(
                height: StyleX.navBarHeight,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  child: BottomNavigationBar(
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: controller.indexPageSelected.value,
                    onTap: controller.onItemSelected,
                    iconSize: StyleX.navBarIconSize,
                    items: controller.pages.map(
                          (page) {
                        return BottomNavigationBarItem(
                          icon: page.icon,
                          label: page.label.tr,
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
