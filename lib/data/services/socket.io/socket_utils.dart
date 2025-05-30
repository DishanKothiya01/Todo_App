// import 'package:get/get.dart';
//
// import '../../../exports.dart';
// import '../../../view_models/chat/chat_view_model.dart';
// import '../../../view_models/connect/connect_view_model.dart';
// import '../../../view_models/connect/widgets/requests_tab_view_model.dart';
// import '../../api/api_utils.dart';
// import '../../firebase/firebase_utils.dart';
// import '../../model/connect/get_exprole_model.dart';
// import '../notification/notification_service.dart';
// import 'socket_controller.dart';
//
// class SocketUtils {
//   SocketUtils._();
//
//   static Future<dynamic> emitSocket({required String socketEvent, Map<String, dynamic>? body, Future<dynamic> Function()? onSuccess}) async {
//     if (await getConnectivityResult()) {
//       try {
//         if (isRegistered<SocketController>()) {
//           final SocketController socketCon = Get.find<SocketController>();
//
//           if (socketCon.socket.connected) {
//             /// Fetch device information
//             final Map<String, dynamic> devicesInfo = await FirebaseUtils.devicesInfo();
//
//             /// Marge custom body (Map) and device information map (Map)
//             Map<String, dynamic> extendMap = {};
//
//             //? Merging (Start)
//             const String deviceIdKey = "device_id";
//
//             extendMap = {
//               if (devicesInfo.containsKey(deviceIdKey)) deviceIdKey: devicesInfo[deviceIdKey],
//               ...?body,
//             };
//             //? Merging (End)
//
//             // printData(key: "Calling emit event", value: ("$socketEvent ${!isValEmpty(body) ? "/ Body: $extendMap" : ""}"));
//
//             socketCon.socket.emit(socketEvent, extendMap);
//
//             if (onSuccess != null) {
//               await onSuccess();
//             }
//           } else {
//             // await socketCon.initializeSocket();
//             printErrors(type: "onSocket Function", errText: "socket not connected");
//
//             // await UiUtils.toast("Please try again.");
//           }
//         }
//       } catch (e) {
//         printErrors(type: "emitSocket function in SocketUtils class", errText: e);
//       }
//     }
//   }
//
//   static Future<dynamic> onSocket({required String socketEvent, required Future<dynamic> Function(dynamic response) handler}) async {
//     if (await getConnectivityResult()) {
//       try {
//         if (isRegistered<SocketController>()) {
//           final SocketController socketCon = Get.find<SocketController>();
//
//           if (socketCon.socket.connected) {
//             printData(key: "Initialize ON event", value: socketEvent);
//             socketCon.socket.on(
//               socketEvent,
//               (response) async {
//                 // printData(key: "ON '$socketEvent' response", value: (response));
//
//                 await handler(response);
//               },
//             );
//           } else {
//             // await socketCon.initializeSocket();
//             printErrors(type: "onSocket Function", errText: "socket not connected");
//
//             // await UiUtils.toast("Please try again.");
//           }
//         }
//       } catch (e) {
//         printErrors(type: "onSocket function in SocketUtils class", errText: e);
//       }
//     }
//   }
//
//   static Future<int> socketStatusAuthenticate(dynamic response, {String? socketEvent}) async {
//     try {
//       //! Note: Status code: 00, message: Unknown mistake
//       if (!isValEmpty(response)) {
//         int status = (!isValEmpty(response["statusCode"]) ? int.tryParse(response["statusCode"].toString()) ?? -1 : -1);
//
//         switch (status) {
//           case 200:
//             return 200;
//
//           case 400:
//             printErrors(type: "Socket Event: $socketEvent", errText: response);
//
//             return 400;
//
//           case 401:
//             printErrors(type: "Socket Event: $socketEvent", errText: response);
//
//             await ApiUtils.logoutAndCleanAllUserData();
//             return 401;
//
//           default:
//             printYellow("Unknown status code in socket on event: $status");
//             return 00;
//         }
//       } else {
//         printWarning("Socket on response empty or null");
//
//         return 00;
//       }
//     } catch (e) {
//       return 00;
//     }
//   }
//
//   //? After accept request has been remove.
//   static Future<void> clearRequest({required String userId, String? conversionId}) async {
//     printData(
//       key: "clearRequest ",
//       value: "userId: $userId" "conversionId: $conversionId",
//     );
//     //?
//     //? Request remove from connect request tab
//     if (isRegistered<RequestsTabViewModel>()) {
//       final RequestsTabViewModel reqCon = Get.find<RequestsTabViewModel>();
//       //
//       // Remove the user from the list.
//       if (!isValEmpty(userId)) {
//         Iterable<ConnectUserModel> listOfReq = reqCon.requestList.where((e) => e.userId == userId);
//
//         for (ConnectUserModel element in listOfReq) {
//           if (!isValEmpty(element.id)) {
//             //? Request remove from connect request tab
//             NotificationService.removeRequestNotification(requestId: element.id ?? "");
//           }
//         }
//
//         //? Remove locally in request list
//         reqCon.requestList.removeWhere((e) => e.userId == userId);
//
//         //? Update the badge label.
//         if (isRegistered<ConnectViewModel>()) {
//           final ConnectViewModel con = Get.find<ConnectViewModel>();
//
//           if ((con.requestTabModel.value.badgeLabel?.value ?? 0) > 0) {
//             con.requestTabModel.value.badgeLabel?.value--;
//           }
//         }
//       }
//     }
//     //?
//     //? Request remove from chat screen and conversion list (details)
//     if (!isValEmpty(conversionId)) {
//       if (Get.isRegistered<ChatViewModel>()) {
//         final ChatViewModel chatCon = Get.find<ChatViewModel>();
//
//         if (chatCon.conversationModel.id == conversionId) {
//           chatCon.connectReqModel?.value = ConnectUserModel();
//         }
//       }
//     }
//   }
// }
