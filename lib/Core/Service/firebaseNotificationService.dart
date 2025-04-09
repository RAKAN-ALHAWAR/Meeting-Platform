// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// import '../../Config/config.dart';

// class FirebaseNotificationServiceX extends ChangeNotifier {

//   static init()async{
//     await FirebaseNotificationServiceX.initializeLocalNotifications(debug: false);
//     await FirebaseNotificationServiceX.initializeRemoteNotifications(debug: false);
//     await FirebaseNotificationServiceX.getInitialNotificationAction();
//     FirebaseNotificationServiceX.startListeningNotificationEvents();
//     FirebaseNotificationServiceX.getFirebaseFcmToken();
//   }

//   /// *********************************************
//   ///   SINGLETON PATTERN
//   /// *********************************************

//   static final FirebaseNotificationServiceX _instance = FirebaseNotificationServiceX._internal();

//   factory FirebaseNotificationServiceX() {
//     return _instance;
//   }

//   FirebaseNotificationServiceX._internal();

//   /// *********************************************
//   ///  OBSERVER PATTERN
//   /// *********************************************

//   String _firebaseToken = '';
//   String get firebaseToken => _firebaseToken;

//   String _nativeToken = '';
//   String get nativeToken => _nativeToken;

//   ReceivedAction? initialAction;

//   /// *********************************************
//   ///   INITIALIZATION METHODS
//   /// *********************************************

//   static Future<void> initializeLocalNotifications(
//       {required bool debug}) async {
//     await AwesomeNotifications().initialize(
//       'resource://drawable/ic_notification',
//       [
//         NotificationChannel(
//           channelKey: 'sound_channel',
//           channelName: 'Alerts',
//             channelDescription: 'Notification tests as alerts',
//             playSound: true,
//             importance: NotificationImportance.High,
//             channelShowBadge: true,
//             criticalAlerts: true,
//             channelGroupKey: 'meeting',
//             defaultPrivacy: NotificationPrivacy.Private,
//             defaultColor: ColorX.primary,
//             ledColor: ColorX.primary,
//         )
//       ],
//       debug: debug,
//     );

//     // Get initial notification action is optional
//     _instance.initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }

//   static Future<void> initializeRemoteNotifications(
//       {required bool debug}) async {
//     await Firebase.initializeApp();
//     await AwesomeNotificationsFcm().initialize(
//         onFcmSilentDataHandle: FirebaseNotificationServiceX.mySilentDataHandle,
//         onFcmTokenHandle: FirebaseNotificationServiceX.myFcmTokenHandle,
//         onNativeTokenHandle: FirebaseNotificationServiceX.myNativeTokenHandle,
//         debug: debug,
//     );
//   }

//   static Future<void> startListeningNotificationEvents() async {
//     AwesomeNotifications().setListeners(onActionReceivedMethod: _onActionReceivedMethod,onNotificationDisplayedMethod: _onNotificationDisplayedMethod);
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future <void> _onNotificationDisplayedMethod(ReceivedNotification val) async {}

//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future <void> _onActionReceivedMethod(ReceivedAction receivedAction) async {
//     // Your code goes here
//     // if(receivedAction.payload?['Route']!=null) {
//     //   Get.toNamed(receivedAction.payload!['Route']!,arguments: receivedAction.payload);
//     // }
//   }

//   ///  *********************************************
//   ///     LOCAL NOTIFICATION EVENTS
//   ///  *********************************************

//   static Future<void> getInitialNotificationAction() async {
//     ReceivedAction? receivedAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: true);
//     if (receivedAction == null) return;
//   }


//   ///  *********************************************
//   ///     REMOTE NOTIFICATION EVENTS
//   ///  *********************************************

//   /// Use this method to execute on background when a silent data arrives
//   /// (even while terminated)
//   @pragma("vm:entry-point")
//   static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
//     if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
//       //code
//     } else {
//       //code
//     }
//     await executeLongTaskInBackground();
//   }

//   /// Use this method to detect when a new fcm token is received
//   @pragma("vm:entry-point")
//   static Future<void> myFcmTokenHandle(String token) async {
//     _instance._firebaseToken = token;
//     _instance.notifyListeners();
//   }

//   /// Use this method to detect when a new native token is received
//   @pragma("vm:entry-point")
//   static Future<void> myNativeTokenHandle(String token) async {
//     _instance._nativeToken = token;
//     _instance.notifyListeners();
//   }

//   ///  *********************************************
//   ///     BACKGROUND TASKS TEST
//   ///  *********************************************

//   static Future<void> executeLongTaskInBackground() async {
//     //code
//   }

//   ///  *********************************************
//   ///     REQUEST NOTIFICATION PERMISSIONS
//   ///  *********************************************

//   static Future<bool> displayNotificationRationale() async {
//     bool userAuthorized = false;
//     await AwesomeNotifications().requestPermissionToSendNotifications();
//     return userAuthorized;
//   }

//   ///  *********************************************
//   ///     LOCAL NOTIFICATION CREATION METHODS
//   ///  *********************************************

//   static Future<void> createNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) {
//       isAllowed = await displayNotificationRationale();
//     }

//     if (!isAllowed) return;

//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1, // -1 is replaced by a random number
//             channelKey: 'alerts',
//             title: 'Huston! The eagle has landed!',
//             body:
//             "A small step for a man, but a giant leap to Flutter's community!",
//             bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//             largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//             notificationLayout: NotificationLayout.BigPicture,
//             payload: {'notificationId': '1234567890'}),
//         actionButtons: [
//           NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//           NotificationActionButton(
//               key: 'REPLY',
//               label: 'Reply Message',
//               requireInputText: true,
//               actionType: ActionType.SilentAction
//           ),
//           NotificationActionButton(
//               key: 'DISMISS',
//               label: 'Dismiss',
//               actionType: ActionType.DismissAction,
//               isDangerousOption: true)
//         ]);
//   }

//   static Future<void> resetBadge() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }

//   ///  *********************************************
//   ///     REMOTE TOKEN REQUESTS
//   ///  *********************************************

//   static Future<String> getFirebaseFcmToken() async {
//     if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
//       try {
//         return await AwesomeNotificationsFcm().requestFirebaseAppToken();
//       } catch (exception) {
//         debugPrint('$exception');
//       }
//     } else {
//       debugPrint('Firebase is not available on this project');
//     }
//     return '';
//   }
// }