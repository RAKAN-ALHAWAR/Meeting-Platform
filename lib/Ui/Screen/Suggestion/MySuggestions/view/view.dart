import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';

import '../../../../../Config/config.dart';
import '../../../../../UI/Animation/animation.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/Custom/Card/suggestionCard.dart';
import '../controller/controller.dart';

class MySuggestionsView extends GetView<MySuggestionsController> {
  const MySuggestionsView({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScrollRefreshLoadMoreXState> key =
    GlobalKey<ScrollRefreshLoadMoreXState>();
    controller.scrollRefreshLoadMoreKey=key;
    return Scaffold(
      appBar: const AppBarX(title: 'My suggestions'),
      body: SafeArea(
        child: ScrollRefreshLoadMoreX(
          key: controller.scrollRefreshLoadMoreKey,
          fetchData: controller.getData,
          padding: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
            vertical: StyleX.vPaddingApp-5,
          ),
          header: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonX(
                onTap: controller.onAddSuggestion,
                text: 'New suggestion',
                iconData: Iconsax.add_square,
                isMaxFinite: false,
              ).fadeAnimation100,
            ],
          ),
          isHideHeaderIfEmpty: true,
          isEmptyCenter:true,
          spaceBetweenHeaderAndContent: 8,
          initLoading: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < 10; i++)
                  const ShimmerAnimationX(
                    height: 117,
                    margin: EdgeInsets.only(bottom: 10),
                  )
              ],
            ),
          ),
          empty: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.receipt_edit,
                color: ColorX.grey.shade300,
                size: 70,
              ).fadeAnimation100,
              const SizedBox(height: 18),
              TextX(
                'You have not added any suggestion yet',
                style: TextStyleX.titleLarge,
              ).fadeAnimation150,
              const SizedBox(height: 12, width: double.infinity),
              ButtonX(
                text: 'Add a new suggestion',
                onTap: controller.onAddSuggestion,
                width: 170,
              ).fadeAnimation200,
            ],
          ),
          pageSize: 15,
          itemBuilder: (data, index) {
            return SuggestionCardX(
              suggestion: data,
              onTap: controller.onSuggestionDetails,
            ).fadeAnimation100;
          },
        ),
      ),
    );
  }
}
