import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../UI/Animation/animation.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/Custom/Card/delegateCard.dart';
import '../../../../Widget/widget.dart';
import '../controller/controller.dart';

class AllDelegatesView extends GetView<AllDelegatesController> {
  const AllDelegatesView({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScrollRefreshLoadMoreXState> key =
    GlobalKey<ScrollRefreshLoadMoreXState>();
    controller.scrollRefreshLoadMoreKey=key;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: StyleX.vPaddingApp,
          left: StyleX.hPaddingApp,
          right: StyleX.hPaddingApp,
        ),
        child: Column(
          children: [
            TabSegmentX(
              controller: controller.type,
              tabs: {
                1: 'Requests sent to me'.tr,
                2: 'Requests sent by me'.tr,
              },
            ).fadeAnimation100.marginOnly(bottom: 4),
            GetBuilder<AllDelegatesController>(
              builder: (controller) => ScrollRefreshLoadMoreX(
                key: controller.scrollRefreshLoadMoreKey,
                fetchData: controller.getData,
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: StyleX.vPaddingApp,
                ),
                initLoading: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < 10; i++)
                        const ShimmerAnimationX(
                          height: 200,
                          margin: EdgeInsets.only(bottom: 8),
                        )
                    ],
                  ),
                ),
                empty: Column(
                  children: [
                    Image.asset(
                      ImageX.delegationEmpty,
                      height: 130,
                    ),
                    const SizedBox(height: 24),
                    TextX(
                      'There are no requests yet',
                      style: TextStyleX.titleLarge,
                    ),
                    const SizedBox(height: 3),
                    TextX(
                      'If new requests are available, they will be shown to you here',
                      fontWeight: FontWeight.w400,
                      color: Get.theme.colorScheme.secondary,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 12),
                  ],
                ).fadeAnimation150,
                isEmptyCenter: true,
                pageSize: 30,
                emptyMessage: 'There are no meetings.',
                itemBuilder: (data, index) {
                  return DelegateCardX(
                    delegate: data,
                    isToMe:controller.isToMe.value,
                    onAccept: controller.onAccept,
                    onReject: controller.onReject,
                  ).fadeAnimation100;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
