// import 'package:get/get.dart';
//
// import '../../../exports.dart';
// import '../../../view_models/bottombar/bottombar_view_model.dart';
// import '../../../view_models/chat/chat_view_model.dart';
// import '../../../view_models/connect/widgets/conversions_tab_view_model.dart';
// import '../../../view_models/connect/widgets/requests_tab_view_model.dart';
// import '../../../view_models/user_profile/user_profile_view_model.dart';
// import '../../api/api_utils.dart';
// import '../../model/connect/get_conversation_model.dart';
// import '../../model/connect/get_exprole_model.dart';
// import 'chat_socket.dart';
// import 'socket_events.dart';
// import 'socket_utils.dart';
//
// class ConversationSocket {
//   ConversationSocket._();
//
//   //* Join User to conversion
//   static Future<void> initializeConversion() async {
//     if (await getConnectivityResult()) {
//       //? User connect to conversion
//       await chatConnectOn().then((_) async => await userConnectEmit());
//
//       //? User status
//       await userStatusOn();
//
//       //? Connect indicator
//       await connectIndicatorOn();
//
//       //? Send request
//       await sendRequestOn();
//
//       //? Message
//       await onIncomingReadMessOn();
//       await onIncomingUnreadMessOn();
//
//       //? Connect request status
//       await connectRequestStatusOn();
//
//       //? Delete conversion
//       await ChatSocket.onIncomingRemoveConversion();
//
//       //? User disconnect
//       await onIncomingUserDisconnectOn();
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                       USER CONNECT TO CONVERSION (ONLINE)                       *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= USER CONNECT EMIT =-=-=-=-=-=-=->>
//   static Future<void> userConnectEmit() async {
//     await SocketUtils.emitSocket(socketEvent: SocketEvents.userConnectEmit);
//   }
//
//   ///* =-=-=-=-=-=-= USER CONNECT ON =-=-=-=-=-=-=->>
//   static Future<void> chatConnectOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.userConnectOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.userConnectOn) == 200) {}
//         },
//       );
//     } catch (e) {
//       printErrors(type: "chatConnectOn Function", errText: e);
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                          USER STATUS (ONLINE OR OFFLINE)                        *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= USER STATUS ON =-=-=-=-=-=-=->>
//   static Future<void> userStatusOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.statusOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.statusOn) == 200) {
//             if (response["data"] != null) {
//               if (Get.isRegistered<ChatViewModel>()) {
//                 final ChatViewModel chatCon = Get.find<ChatViewModel>();
//                 chatCon.userStatus.value = (response?["data"]?["status"] ?? false);
//               }
//             }
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "userStatusOn Function", errText: e);
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                                CONNECT INDICATOR                                *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= CONNECT INDICATOR ON =-=-=-=-=-=-=->>
//   static Future<void> connectIndicatorOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.connectIndicatorOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.connectIndicatorOn) == 200) {
//             if (response["data"] != null) {
//               if (Get.isRegistered<BottombarViewModel>()) {
//                 final BottombarViewModel bottomCon = Get.find<BottombarViewModel>();
//
//                 if (response?["data"]?["count"] != null) {
//                   bottomCon.isConnectShowBadge.value = (response?["data"]?["count"] ?? 0);
//                 }
//               }
//             }
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "connectIndicatorOn Function", errText: e);
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                                  SEND REQUEST                                   *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= SEND REQUEST EMIT =-=-=-=-=-=-=->>
//   static Future<void> sendRequestEmit({required String friendId, String? conversionId}) async {
//     await SocketUtils.emitSocket(
//       socketEvent: SocketEvents.sendRequestEmit,
//       body: {
//         'send_to': friendId,
//         if (!isValEmpty(conversionId)) 'conversation_id': conversionId,
//       },
//     );
//   }
//
//   ///* =-=-=-=-=-=-= SEND REQUEST ON =-=-=-=-=-=-=->>
//   static Future<void> sendRequestOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.sendRequestOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.sendRequestOn) == 200) {
//             if (!isValEmpty(response["data"])) {
//               final ConnectUserModel connectUserModel = ConnectUserModel.fromJson(response["data"]);
//
//               /// Show connection request in the Connect request tab
//               if (isRegistered<RequestsTabViewModel>()) {
//                 await Get.find<RequestsTabViewModel>().insertObject(connectUserModel);
//               }
//
//               /// Show connection request on chat view
//               String? conversionId = response?['conversion_id']?.toString() ?? "";
//
//               if (Get.isRegistered<ChatViewModel>()) {
//                 if (!isValEmpty(conversionId)) {
//                   final ChatViewModel chatCon = Get.find<ChatViewModel>();
//
//                   printOkStatus("$conversionId == ${chatCon.conversationModel.id}");
//
//                   if (chatCon.conversationModel.id == conversionId) {
//                     chatCon.connectReqModel?.value = connectUserModel;
//                   }
//                 } else {
//                   printErrors(type: "sendRequestOn Function", errText: "conversionId not found");
//                 }
//               }
//             }
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "sendRequestOn Function", errText: e);
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                        RECEIVE MESSAGES AFTER USER ONLINE                       *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= RECEIVE READ IN-COMING MESSAGES ON =-=-=-=-=-=-=->>
//   static Future<void> onIncomingReadMessOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.readMessageOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.readMessageOn) == 200) {
//             if (response['data'] != null) {
//               /// READ MESSAGE
//               if (Get.isRegistered<ConversionsTabViewModel>()) {
//                 final ConversionsTabViewModel conversionCon = Get.find<ConversionsTabViewModel>();
//                 await conversionCon.upgradeObject(messageCount: (int.tryParse(response['data']['total_messages'].toString()) ?? 0), newModel: ConversationModel.fromJson(response['data']));
//               }
//             }
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "onIncomingReadMessOn Function", errText: e);
//     }
//   }
//
//   ///* =-=-=-=-=-=-= RECEIVE UNREAD IN-COMING MESSAGES ON =-=-=-=-=-=-=->>
//   static Future<void> onIncomingUnreadMessOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.unreadMessageOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.unreadMessageOn) == 200) {
//             if (response['data'] != null) {
//               /// UNREAD MESSAGE
//               if (Get.isRegistered<ConversionsTabViewModel>()) {
//                 final ConversionsTabViewModel conversionCon = Get.find<ConversionsTabViewModel>();
//                 await conversionCon.upgradeObject(messageCount: (int.tryParse(response['data']['total_messages'].toString()) ?? 0), newModel: ConversationModel.fromJson(response['data']));
//               }
//             }
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "onIncomingUnreadMessOn Function", errText: e);
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                                CONNECT REQUEST                                  *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= CONNECT REQUEST ON =-=-=-=-=-=-=->>
//   static Future<void> connectRequestStatusEmit({required bool isReject, RxBool? isLoader, required List<String> friendIdList}) async {
//     String reqStatus = isReject ? 'reject' : 'accept'; // "status" must be one of [accept, reject]"
//
//     isLoader?.value = true;
//
//     await SocketUtils.emitSocket(
//       socketEvent: SocketEvents.connectRequestStatusEmit,
//       body: {
//         if (!isValEmpty(reqStatus)) 'status': reqStatus,
//         "reqIds": friendIdList,
//       },
//     );
//   }
//
//   ///* =-=-=-=-=-=-= CONNECT REQUEST ON =-=-=-=-=-=-=->>
//   static Future<void> connectRequestStatusOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.connectRequestStatusOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.connectRequestStatusOn) == 200) {
//             if (response["data"] != null) {
//               // Store status
//               final String status = response["status"].toString();
//
//               String userId = "";
//
//               String conversionId = "";
//
//               // Check request status
//               if (status == "accept") {
//                 printYellow("${SocketEvents.connectRequestStatusOn}/ status: accept");
//                 final ConversationModel conversionModel = ConversationModel.fromJson(response['data']);
//
//                 //? Store user id
//                 userId = conversionModel.sender?.id.toString() ?? "";
//
//                 //? Store conversion id
//                 conversionId = conversionModel.id.toString();
//
//                 //? Insert accepted request into the conversation (MESSAGE) list then remove request from request list
//                 if (Get.isRegistered<ConversionsTabViewModel>()) {
//                   final ConversionsTabViewModel conversionCon = Get.find<ConversionsTabViewModel>();
//                   await conversionCon.insertObject(ConversationModel.fromJson(response['data']));
//                 }
//               } else if (status == "reject") {
//                 printYellow("${SocketEvents.connectRequestStatusOn}/ status: reject");
//
//                 //? Store user id
//                 if (response["data"]["user"] != null) {
//                   userId = response["data"]["user"].toString();
//                 } else {
//                   printErrors(type: "connectRequestStatusOn Function", errText: "Status rejected error: userId not found");
//                 }
//
//                 //? Store conversion id
//                 if (response["conversation_id"] != null) {
//                   conversionId = response["conversation_id"].toString();
//                 }
//               }
//
//               //? After accept request has been remove.
//               await SocketUtils.clearRequest(userId: userId, conversionId: conversionId);
//             }
//           } else {}
//         },
//       );
//     } catch (e) {
//       printErrors(type: "connectRequestStatusOn Function", errText: e);
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                     USER DISCONNECT TO CONVERSION (OFFLINE)                     *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= USER DISCONNECT EMIT =-=-=-=-=-=-=->>
//   static Future<void> userDisconnectEmit({String? type}) async {
//     await SocketUtils.emitSocket(
//       socketEvent: SocketEvents.disconnectUserEmit,
//       body: {
//         if (!isValEmpty(type)) 'type': type,
//         "user": LocalStorage.userId.value,
//       },
//     );
//   }
//
//   ///* =-=-=-=-=-=-= USER DISCONNECT ON =-=-=-=-=-=-=->>
//   static Future<void> onIncomingUserDisconnectOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.disconnectUserOn,
//         handler: (response) async {
//           switch (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.disconnectUserOn)) {
//             case 200:
//               await ApiUtils.manageLogoutAndDeleteStatus(statusType: response?["data"]?["type"].toString() ?? "");
//
//               break;
//
//             default:
//               if (Get.isRegistered<UserProfileViewModel>()) {
//                 final UserProfileViewModel userProfileCon = Get.find<UserProfileViewModel>();
//                 userProfileCon.isLogoutLoading.value = false;
//                 userProfileCon.isDeleteLoading.value = false;
//                 break;
//               }
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "onIncomingUserDisconnectOn Function", errText: e);
//     }
//   }
// }
