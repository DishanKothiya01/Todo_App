// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart';
//
// import '../../../exports.dart';
// import '../../../view_models/chat/chat_view_model.dart';
// import 'chat_socket.dart';
// import 'conversation_socket.dart';
//
// /*!
//     [_socketCon.socket.connected] Don't use this because it's not working properly
// !*/
//
// class SocketController extends GetxController {
//   late Socket socket;
//   RxBool socketOnline = false.obs;
//
//   @override
//   void onReady() {
//     super.onReady();
//
//     printYellow("-=-=-=-=-> SocketController onReady <-=-=-=-=-");
//
//     initializeSocket();
//   }
//
//   Future<void> initializeSocket() async {
//     try {
//       if (socketOnline.isFalse) {
//         printData(key: "Function initializeSocket", value: true);
//
//         socket = io(
//           ApiUrls.baseUrl(ignoreVersion: true),
//           OptionBuilder()
//               .setTransports(['websocket'])
//               .disableAutoConnect()
//               .disableForceNewConnection()
//               .setExtraHeaders(
//                 {
//                   'token': LocalStorage.accessToken.value,
//                 },
//               )
//               .build(),
//         );
//       }
//
//       socket.connect();
//
//       socket.onConnect(
//         (data) async {
//           socketOnline.value = true;
//
//           printData(key: "Socket Connection Established", value: true);
//
//           printData(key: "Socket Id", value: socket.id);
//
//           ///* =-= CONNECT ALL CONVERSION EVENTS =-=->>
//           await ConversationSocket.initializeConversion();
//
//           ///* =-= CONNECT ALL CHAT EVENTS =-=->>
//           if (Get.isRegistered<ChatViewModel>()) {
//             await ChatSocket.initializeChat();
//           }
//         },
//       );
//
//       socket.onConnectError(
//         (data) {
//           socketOnline.value = false;
//           printErrors(type: "Socket onConnectError Function", errText: '$data');
//         },
//       );
//
//       socket.onReconnect(
//         (data) {
//           printErrors(type: "Socket onReconnect Function", errText: '$data');
//         },
//       );
//
//       socket.onDisconnect(
//         (data) async {
//           socketOnline.value = false;
//           printErrors(type: "Socket onDisconnect Function", errText: '$data');
//         },
//       );
//
//       socket.onError(
//         (err) {
//           socketOnline.value = false;
//           printErrors(type: "Socket onError Function", errText: '$err');
//         },
//       );
//     } catch (e) {
//       printErrors(type: "initializeSocket Function", errText: e);
//     }
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//
//     printYellow("-=-=-=-=-> SocketController onClose <-=-=-=-=-");
//
//     socket.disconnect();
//     socket.dispose();
//     socket.close();
//   }
// }
