part of '../../widget.dart';

bottomSheetDangerousX({
  required IconData icon,
  required String title,
  required String message,
  required Function onOk,
  required String okText,
  String cancelText = "Cancel",
}) {
  return bottomSheetX(
    padding: EdgeInsets.only(bottom: 20+ MediaQuery.of(Get.context!).padding.bottom,top: 30,right: StyleX.bottomSheetPadding,left: StyleX.bottomSheetPadding),
    child: Column(
      children: [
        ContainerX(
          radius: StyleX.radiusLg,
          color: ColorX.danger.shade100,
          padding: const EdgeInsets.all(20),
          isBorder: false,
          child: Icon(
            icon,
            size: 38,
            color: ColorX.danger.shade600,
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        TextX(
          title,
          style: TextStyleX.headerMedium,
          color: ColorX.danger.shade600,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        TextX(
          message,
          style: TextStyleX.titleSmall,
          color: Get.theme.colorScheme.secondary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Flexible(child: ButtonX(onTap: () => Get.back(), text: cancelText)),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: ButtonX.dangerous(
                onTap: () async {
                  Get.back();
                  await onOk();
                },
                text: okText,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
