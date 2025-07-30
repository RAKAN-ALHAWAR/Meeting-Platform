part of '../../widget.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({required this.notification, super.key, required this.onAcceptDelegate, required this.onRejectDelegate});
  final NotificationX notification;
  final Function(NotificationX) onAcceptDelegate;
  final Function(NotificationX) onRejectDelegate;
  @override
  Widget build(BuildContext context) {
    RootController root = Get.find();
    openMeeting({bool isTask=false,bool isVote=false,}){
     Get.toNamed(RouteNameX.meetingDetails,arguments: notification.data.meetingId,parameters: {
       if(isTask)NameX.task:'true',
       if(isVote)NameX.vote:'true',
     });
    }
    return GestureDetector(
      onTap: openMeeting,
      child: ContainerX(
        isBorder: false,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(16.0),
        radius: StyleX.radiusLg,
        child: Column(
          children: [
            Row(
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
                      Row(
                        children: [
                          if(notification.data.type==NotificationTypeStatusX.alertMeeting)
                            Container(
                              constraints: BoxConstraints(minWidth: 150),
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonX(
                                isMaxFinite: false,
                                marginVertical: 0,
                                onTap: openMeeting,
                                text: "View modifications",
                                colorText: Get.theme.iconTheme.color,
                                borderColor: Colors.transparent,
                                colorButton: context.isDarkMode?ColorX.grey.shade400:ColorX.grey.shade100,
                              ),
                            ),

                          if(notification.data.type==NotificationTypeStatusX.minutesMeeting)
                            Container(
                              constraints: BoxConstraints(minWidth: 150),
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonX(
                                isMaxFinite: false,
                                marginVertical: 0,
                                onTap: ()=> Get.toNamed(RouteNameX.meetingMinutes, arguments: notification.data.meetingId),
                                text: "View meeting minutes",
                                colorText: Get.theme.iconTheme.color,
                                borderColor: Colors.transparent,
                                colorButton: context.isDarkMode?ColorX.grey.shade400:ColorX.grey.shade100,
                              ),
                            ),

                          if(notification.data.type==NotificationTypeStatusX.confirmAttendanceMeeting)
                            Container(
                              constraints: BoxConstraints(minWidth: 150),
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonX(
                                isMaxFinite: false,
                                marginVertical: 0,
                                onTap: openMeeting,
                                text: "Confirm attendance",
                                colorText: Get.theme.iconTheme.color,
                                borderColor: Colors.transparent,
                                colorButton: context.isDarkMode?ColorX.grey.shade400:ColorX.grey.shade100,
                              ),
                            ),

                          if(notification.data.type==NotificationTypeStatusX.newTask)
                            Container(
                              constraints: BoxConstraints(minWidth: 150),
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonX(
                                isMaxFinite: false,
                                marginVertical: 0,
                                onTap: ()=>openMeeting(isTask:true),
                                text: "View tasks",
                                colorText: Get.theme.iconTheme.color,
                                borderColor: Colors.transparent,
                                colorButton: context.isDarkMode?ColorX.grey.shade400:ColorX.grey.shade100,
                              ),
                            ),

                          if(notification.data.type==NotificationTypeStatusX.voteMeeting)
                            Container(
                              constraints: BoxConstraints(minWidth: 150),
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonX(
                                isMaxFinite: false,
                                marginVertical: 0,
                                onTap: ()=>openMeeting(isVote:true),
                                text: "Vote now",
                                colorText: Get.theme.iconTheme.color,
                                borderColor: Colors.transparent,
                                colorButton: context.isDarkMode?ColorX.grey.shade400:ColorX.grey.shade100,
                              ),
                            ),

                          if(notification.data.type==NotificationTypeStatusX.requestsDelegate)
                            Container(
                              constraints: BoxConstraints(minWidth: 150),
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonX(
                                isMaxFinite: false,
                                marginVertical: 0,
                                onTap: (){
                                  root.openDelegates();
                                  Get.back();
                                },
                                text: "View delegations",
                                colorText: Get.theme.iconTheme.color,
                                borderColor: Colors.transparent,
                                colorButton: context.isDarkMode?ColorX.grey.shade400:ColorX.grey.shade100,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // if(notification.data.type==NotificationTypeStatusX.confirmAttendanceMeeting)
            //   Row(
            //     children: [
            //       Flexible(
            //         child: ButtonX(
            //           marginVertical: 0,
            //           onTap: ()async=>await onAcceptDelegate(notification),
            //           text: "Approve the request",
            //         ),
            //       ),
            //       const SizedBox(width: 10),
            //       Flexible(
            //         child: ButtonX.dangerous(
            //           marginVertical: 0,
            //           onTap: ()async=>await onRejectDelegate(notification),
            //           text: "Request rejected",
            //         ),
            //       ),
            //     ],
            //   ),


          ],
        ),
      ),
    );
  }
}
