part of '../../widget.dart';

bottomSheetSuccessX({
  required IconData icon,
  required String title,
  String? message,
  required Function onOk,
  required String okText,
  String cancelText = "Cancel",
}) {
  return bottomSheetX(
    padding: EdgeInsets.only(bottom: 20+ MediaQuery.of(Get.context!).padding.bottom,top: 30,right: StyleX.bottomSheetPadding,left: StyleX.bottomSheetPadding),
    child: Column(
      children: [
        ContainerX(
          radius: StyleX.radiusMd,
          color: Get.theme.colorScheme.onPrimary,
          padding: const EdgeInsets.all(20),
          child: Icon(
            icon,
            size: 38,
            color: Get.theme.primaryColorDark,
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        TextX(
          title,
          style: TextStyleX.headerMedium,
          color: Get.theme.primaryColor,
          textAlign: TextAlign.center,
        ),
        if(message!=null)
        TextX(
          message,
          style: TextStyleX.titleSmall,
          color: Get.theme.colorScheme.secondary,
          textAlign: TextAlign.center,
        ).marginOnly(top: 5),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Flexible(
              child: ButtonX(
                onTap: () async {
                  Get.back();
                  await onOk();
                },
                text: okText,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: ButtonX.gray(
                onTap: () => Get.back(),
                text: cancelText,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
