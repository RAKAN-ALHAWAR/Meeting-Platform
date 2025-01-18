part of '../../widget.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({required this.notification, super.key});
  final NotificationX notification;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.toNamed(RouteNameX.meetingDetails,arguments: notification.data.meetingId,),
      child: ContainerX(
        isBorder: false,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(20.0),
        radius: StyleX.radiusLg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerX(
              padding: const EdgeInsets.all(14.0),
              color: Theme.of(context).colorScheme.onPrimary,
              radius: StyleX.radiusMd,
              child: Icon(
                Iconsax.notification_bing,
                color: ColorX.primary,
                size: 28.0,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextX(
                    notification.data.type.name,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 6.0),
                  TextX(
                    notification.data.msg,
                    style: TextStyleX.supTitleLarge,
                    size: 15,
                  ),
                  const SizedBox(height: 8.0),
                  TextX(
                    intl.DateFormat('h:mm a  yyyy/MM/dd',TranslationX.getLanguageCode).format(notification.createdAt),
                    size: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorX.grey.shade400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
