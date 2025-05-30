// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../../../exports.dart';
// import '../../../view_models/bottombar/bottombar_view_model.dart';
// import '../../api/api_utils.dart';
// import 'notification_enum.dart';
//
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// abstract class NotificationService {
//   NotificationService._();
//
//   static AndroidNotificationChannel timerChannel = const AndroidNotificationChannel(
//     'TIMER',
//     'Timer',
//     description: 'This channel is used for Pet Walking',
//     importance: Importance.min,
//   );
//
//   static Future<void> init() async {
//     await getNotificationPermission();
//     await firebaseMessagingInit();
//     await getMessage();
//     cancelNotification(ApiUtils.walkNotificationId); // Walk timer local notification clear
//   }
//
//   static Future getNotificationPermission() async {
//     await FirebaseMessaging.instance.requestPermission();
//     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//
//     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(timerChannel);
//   }
//
//   static Future<void> firebaseMessagingInit() async {
//     AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('ic_notification');
//     DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );
//     InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onSelectNotification,
//     );
//   }
//
//   static Future<dynamic> onSelectNotification(NotificationResponse notificationResponse) async {
//     debugPrint("-=-=-=-=-=-=-> onSelectNotification <-=-=-=-=-=--=-");
//     if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
//       navigation(notificationResponse.payload, state: NotificationState.open);
//     }
//   }
//
//   static Future<void> getMessage() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // KILL APP
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
//       debugPrint("-=-=-=-=-=-=-> getInitialMessage <-=-=-=-=-=--");
//       if (message != null) {
//         Future.delayed(const Duration(seconds: 3), () {
//           navigation(message.data, state: NotificationState.kill);
//         });
//       }
//     });
//
//     // BACKGROUND
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
//       debugPrint("-=-=-=-=-=-=-> onMessageOpenedApp <-=-=-=-=-=--");
//       if (message != null) {
//         navigation(message.data, state: NotificationState.background);
//       }
//     });
//
//     // OPEN APP
//     FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
//       debugPrint("-=-=-=-=-=-=-> onMessage <-=-=-=-=-=--");
//
//       await NotificationType.fromSlugToAction(message, state: NotificationState.open);
//     });
//
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       badge: true,
//       alert: true,
//       sound: true,
//     );
//   }
//
//   static Future<void> showNotification({RemoteMessage? remoteMessage}) async {
//     final AndroidNotificationChannel channel = AndroidNotificationChannel(
//       remoteMessage?.data['id'] ?? 'high_importance_channel',
//       'High Importance Notifications',
//       description: 'This channel is used for important notifications.',
//       sound: const RawResourceAndroidNotificationSound('notification_sound'),
//       importance: Importance.high,
//     );
//
//     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//
//     printYellow("Notification id: ${channel.id}");
//
//     AndroidNotificationDetails android = AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       channelDescription: channel.description,
//       priority: Priority.high,
//       importance: Importance.max,
//       sound: channel.sound,
//     );
//
//     DarwinNotificationDetails iOS = const DarwinNotificationDetails(
//       presentSound: true,
//       presentAlert: true,
//       presentBadge: true,
//       sound: 'notification_sound.wav',
//     );
//
//     printYellow(int.tryParse(remoteMessage?.data['id'].toString() ?? ""));
//     printWarning(int.tryParse(remoteMessage?.data['id'].toString() ?? "") ?? remoteMessage!.notification.hashCode.toString());
//
//     final int customNotificationId = int.tryParse(remoteMessage?.data['id'].toString() ?? "") ?? remoteMessage!.notification.hashCode;
//
//     printWhite("Channel id: ${channel.id}");
//     printWhite("Channel id: $customNotificationId");
//
//     NotificationDetails platform = NotificationDetails(android: android, iOS: iOS);
//     await flutterLocalNotificationsPlugin.show(
//       customNotificationId,
//       // remoteMessage!.notification.hashCode,
//       remoteMessage!.notification!.title,
//       remoteMessage.notification!.body,
//       platform,
//       payload: jsonEncode(remoteMessage.data),
//     );
//   }
//
//   static Future<void> cancelNotification(int id) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
//
//   static void navigation(payload, {required NotificationState state}) async {
//     final Map<String, dynamic> newPay = payload.runtimeType == String ? jsonDecode(payload) : payload;
//
//     debugPrint("../${newPay.toString()}..");
//
//     // if (!isValEmpty(LocalStorage.accessToken.value)) {
//     //   if (state != NotificationState.open) {}
//
//     //   if (Get.isRegistered<BottombarViewModel>()) {
//     //     // Get.find<BottombarViewModel>().currentBottomIndex.value = 3;
//     //   }
//     //   if (!isValEmpty(newPay['screen-route']) && Get.currentRoute != AppRoutes.walkInProgressView) {
//     //     Get.toNamed(AppRoutes.walkInProgressView);
//     //   }
//     // }
//
//     ///* -=-=-=-=-=-=-= GLOBALLY -=-=-=-=-=-=-=-==->
//     if (!isValEmpty(newPay) && !isValEmpty(newPay['notification_type'])) {
//       await Future.delayed(
//         Durations.short3,
//         () async {
//           //! First create bottombar route than navigate any route.
//           if (isRegistered<BottombarViewModel>() && await getConnectivityResult()) {
//             await NotificationType.fromSlugToNavigate(newPay['notification_type'], payload: newPay);
//           }
//         },
//       );
//     } else {
//       printErrors(type: "Notification payload isEmpty", errText: newPay);
//     }
//   }
//
//   ///***********************************************************************************///
//   ///*         MANAGE DIALOG SHOW OR NOTIFICATIONS [TRUE TO SHOW NOTIFICATION]         *///
//   ///***********************************************************************************///
//
//   /*
//   /// FOR THE TESTING NOTIFICATION - COPY THIS ANY ON-TAP
//     // It's a notification data
//     onTap: () async {
//     Map<String, dynamic> data = {
//       "clickAction": "NOTIFICATION_CLICK",
//       "notification_type": "deworming",
//       "pet_images": [
//         {
//           "_id": "6686a19354c49b9e51f808da",
//           "user": "6686a18054c49b9e51f808c1",
//           "pet_name": "Tammy",
//           "pet_image": "https://happypetstaging.s3.ap-south-1.amazonaws.com/parentsPet/6686a18054c49b9e51f808c1/petImage/large_file_1720099239008.webp",
//         },
//       ],
//       "type": "reminder",
//       "type_id": "Title",
//       "description": "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description"
//     };
//     await NotificationService.showNotificationOrReminderDialog(
//       reminderId: data['type_id'],
//       reminderCategory: data['notification_type'],
//       title: data['title'],
//       desecration: data['description'],
//       petList: data["pet_images"] == null ? [] : List<Pet>.from(data["pet_images"]!.map((x) => Pet.fromJson(x))),
//     );
//   },
//   */
//
//   /* Future<void> getNot() async {
//       List<ActiveNotification> pendingNotifications = await flutterLocalNotificationsPlugin.getActiveNotifications();
//
//       printWarning(pendingNotifications.length);
//       for (var notification in pendingNotifications) {
//         printOkStatus('ID: ${notification.id}, Title: ${notification.title}, Body: ${notification.channelId}');
//       }
//     }
//
//     getNot(); */
//
//   ///***********************************************************************************///
//   ///*                                   PET WALKING                                   *///
//   ///***********************************************************************************///
//
//   static Future<void> showTimerNotification({required String title, String? subTitle}) async {
//     // printYellow("showTimerNotification");
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         timerChannel.id,
//         timerChannel.name,
//         channelDescription: timerChannel.description,
//         importance: Importance.none,
//         priority: Priority.min,
//         ongoing: true,
//         // channelShowBadge: true,
//       ),
//       iOS: const DarwinNotificationDetails(
//         presentSound: false,
//         presentAlert: false,
//         presentBadge: false,
//         presentBanner: false,
//         interruptionLevel: InterruptionLevel.passive,
//         presentList: true,
//       ),
//     );
//     await flutterLocalNotificationsPlugin.show(
//       ApiUtils.walkNotificationId,
//       title,
//       subTitle,
//       notificationDetails,
//       payload: jsonEncode(
//         {
//           "notification_type": NotificationType.currentlyWalking.slug,
//         },
//       ),
//     );
//   }
//
//   static Future<List<ActiveNotification>> removeConversationNotification({required String conversationId}) async {
//     List<ActiveNotification> pendingNotifications = await flutterLocalNotificationsPlugin.getActiveNotifications();
//
//     List<ActiveNotification> commonNotification = pendingNotifications.where(
//       (element) {
//         return element.channelId == conversationId;
//       },
//     ).toList();
//
//     for (int i = 0; i < commonNotification.length; i++) {
//       if (commonNotification[i].id != null) {
//         flutterLocalNotificationsPlugin.cancel(commonNotification[i].id!);
//       }
//     }
//     return pendingNotifications;
//   }
//
//   static Future<List<ActiveNotification>> removeRequestNotification({required String requestId}) async {
//     List<ActiveNotification> pendingNotifications = await flutterLocalNotificationsPlugin.getActiveNotifications();
//
//     List<ActiveNotification> commonNotification = pendingNotifications.where(
//       (element) {
//         return element.channelId == requestId;
//       },
//     ).toList();
//
//     for (int i = 0; i < commonNotification.length; i++) {
//       if (commonNotification[i].id != null) {
//         flutterLocalNotificationsPlugin.cancel(commonNotification[i].id!);
//       }
//     }
//     return pendingNotifications;
//   }
// }
