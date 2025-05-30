// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../exports.dart';
// import '../../../view_models/chat/chat_view_model.dart';
// import '../../model/connect/get_chat_model.dart';
// import '../../model/socket/socket_model.dart';
// import 'socket_events.dart';
// import 'socket_utils.dart';
//
// class ChatSocket {
//   ChatSocket._();
//
//   //* Join User
//   static Future<void> initializeChat() async {
//     if (await getConnectivityResult()) {
//       final ChatViewModel chatCon = Get.find<ChatViewModel>();
//
//       //? Chat join
//       await onIncomingJoinChat().then((_) async => await emitJoinChat(conversationId: chatCon.conversationModel.id ?? ""));
//
//       //? Message
//       await onIncomingMessageOn();
//
//       //? Chat leave
//       await onIncomingLeaveChat();
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                                USER JOIN TO CHAT                                *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= CHAT JOIN EMIT =-=-=-=-=-=-=->>
//   static Future<void> emitJoinChat({required String conversationId}) async {
//     await SocketUtils.emitSocket(
//       socketEvent: SocketEvents.chatJoinEmit,
//       body: {
//         'conversation': conversationId,
//       },
//     );
//   }
//
//   ///* =-=-=-=-=-=-= CHAT JOIN ON =-=-=-=-=-=-=->>
//   static Future<void> onIncomingJoinChat() async {
//     await SocketUtils.onSocket(
//       socketEvent: SocketEvents.chaJoinOn,
//       handler: (response) async {
//         if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.chaJoinOn) == 200) {}
//       },
//     );
//   }
//
//   /// ***********************************************************************************
//   /// *                               USER LEAVE TO CHAT                                *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= CHAT LEAVE EMIT =-=-=-=-=-=-=->>
//   static Future<void> chatLeaveEmit({required String conversationId}) async {
//     await SocketUtils.emitSocket(
//       socketEvent: SocketEvents.chatLeaveEmit,
//       body: {
//         'conversation': conversationId,
//       },
//     );
//   }
//
//   ///* =-=-=-=-=-=-= CHAT LEAVE ON =-=-=-=-=-=-=->>
//   static Future<void> onIncomingLeaveChat() async {
//     await SocketUtils.onSocket(
//       socketEvent: SocketEvents.chatLeaveOn,
//       handler: (response) async {
//         if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.chatLeaveOn) == 200) {}
//       },
//     );
//   }
//
//   /// ***********************************************************************************
//   /// *                               USER SEND MESSAGE                                 *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= USER SEND MESSAGE EMIT =-=-=-=-=-=-=->>
//   static Future<void> sendMessageEmit({required String conversationId, required String? message, required int msgCount}) async {
//     if (!isValEmpty(message)) {
//       await SocketUtils.emitSocket(
//         socketEvent: SocketEvents.sendMessageEmit,
//         body: {
//           'conversation': conversationId,
//           'message': message,
//           'msg_count': msgCount,
//         },
//         onSuccess: () async {
//           if (Get.isRegistered<ChatViewModel>()) {
//             final ChatViewModel chatCon = Get.find<ChatViewModel>();
//
//             chatCon.messageList.insert(
//               0,
//               MessageModel(
//                 sender: LocalStorage.userId.value,
//                 //! [isSend] is not working properly so send message status is directly true.
//                 isSend: RxBool(true),
//                 // isSend: RxBool(false),
//                 createdAt: DateTime.now(),
//                 message: message,
//                 msgCount: msgCount,
//               ),
//             );
//
//             chatCon.totalMessCont++;
//           }
//         },
//       );
//     }
//   }
//
//   /*
//       /// Manage by role
//     if (LocalStorage.userId.value == (socketModel.data?.createMessage?.sender ?? "")) {
//       //? User self message
//     } else {
//       //? Another user message
//     }
//   */
//
//   ///* =-=-=-=-=-=-= INCOMING USER MESSAGE ON =-=-=-=-=-=-=->>
//   static Future<void> onIncomingMessageOn() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.sendMessageOn,
//         handler: (response) async {
//           if (response['data'] != null) {
//             switch (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.sendMessageOn)) {
//               case 200:
//                 final GetSocketModel socketModel = GetSocketModel.fromJson(response);
//
//                 if (socketModel.data != null && socketModel.data?.createMessage != null) {
//                   if (Get.isRegistered<ChatViewModel>()) {
//                     final ChatViewModel chatCon = Get.find<ChatViewModel>();
//
//                     // final bool exists = chatCon.messageList.any((e) => e.id == socketModel.data?.createMessage?.id);
//
//                     final int messIndex = chatCon.messageList.indexWhere((p0) => p0.msgCount == socketModel.data?.createMessage?.msgCount);
//
//                     if (messIndex != -1) {
//                       /// Existing message upgrade in chat lis
//                       chatCon.messageList[messIndex] = MessageModel.fromJson(socketModel.data!.createMessage!.toJson());
//                     } else {
//                       /// Message direct add in chat list
//                       chatCon.messageList.insert(0, MessageModel.fromJson(socketModel.data!.createMessage!.toJson()));
//                     }
//                   }
//                 }
//
//                 break;
//             }
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "onIncomingMessageOn Function", errText: e);
//     }
//   }
//
//   /// ***********************************************************************************
//   /// *                              REMOVE CONVERSATION                                *
//   /// ***********************************************************************************
//
//   ///* =-=-=-=-=-=-= REMOVE CONVERSATION EMIT =-=-=-=-=-=-=->>
//   static Future<void> removeConversionEmit({required String conversationId, required VoidCallback onStart}) async {
//     onStart();
//
//     await SocketUtils.emitSocket(
//       socketEvent: SocketEvents.removeConversionEmit,
//       body: {
//         'conversation': conversationId,
//       },
//     );
//   }
//
//   ///* =-=-=-=-=-=-= REMOVE CONVERSATION ON =-=-=-=-=-=-=->>
//   static Future<void> onIncomingRemoveConversion() async {
//     try {
//       await SocketUtils.onSocket(
//         socketEvent: SocketEvents.removeConversionOn,
//         handler: (response) async {
//           if (await SocketUtils.socketStatusAuthenticate(response, socketEvent: SocketEvents.removeConversionOn) == 200) {
//             //! It's use in without reconnect functionality.
//             /* /// Set conversation id form socket conversation id.
//             String? conversionSocketId = response?['data']?['conversation']?.toString() ?? "";
//
//             if (!isValEmpty(conversionSocketId)) {
//               //? Remove conversation from conversation screen
//               if (Get.isRegistered<ConversionsTabViewModel>()) {
//                 final ConversionsTabViewModel conCon = Get.find<ConversionsTabViewModel>();
//
//                 conCon.conversationList.removeWhere(
//                   (element) {
//                     return element.id == conversionSocketId;
//                   },
//                 );
//
//                 await conCon.upgradeUnreadMessCount();
//               }
//
//               //? In user is open chat section
//               if (Get.isRegistered<ChatViewModel>()) {
//                 final ChatViewModel chatCon = Get.find<ChatViewModel>();
//
//                 /* if (chatCon.conversationModel.id == conversionSocketId) {
//                   // If user is currently open chat screen
//                   if (Get.currentRoute == AppRoutes.chatView) {
//                     // Close keyboard or sheets, and then beck to conversation screen
//                     Get.back(closeOverlays: true);
//                   }
//                 } */
//                 chatCon.isRemoving.value = false;
//               }
//             } else {
//               printErrors(type: "onIncomingRemoveConversation Function", errText: "conversation id not found in socket response");
//             } */
//           }
//         },
//       );
//     } catch (e) {
//       printErrors(type: "onIncomingRemoveConversion Function", errText: e);
//     }
//   }
// }
