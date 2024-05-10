// import 'package:aikon/cometchat/cometchat_service.dart';
// import 'package:aikon/controller/cometchat_controller.dart';
// import 'package:aikon/controller/offer_controller.dart';
// import 'package:aikon/screens/widgets/circular_indicator.dart';
// import 'package:aikon/utilities/pick_images.dart';
// import 'package:cometchat_sdk/cometchat_sdk.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State with MessageListener {
//   TextEditingController chatController = TextEditingController();
//   final _cometChatController = Get.put(CometChatController());
//   final OfferController _offerController = Get.put(OfferController());

//   late Map dataGetx;

//   @override
//   void initState() {
//     super.initState();

//     initialize();
//   }

//   void initialize() async {
//     _cometChatController.loadingChats.value = true;
//     CometChat.addMessageListener('_listenerId', this);

//     dataGetx = Get.arguments;
//     print(dataGetx["uid"]);
//     _cometChatController.loadingChats.value = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat Screen'),
//       ),
//       body: Obx(
//         () => _cometChatController.loadingChats.value
//             ? circularCenterScreenIndicator()
//             : Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   children: <Widget>[
//                     Expanded(
//                       child: SingleChildScrollView(
//                         reverse: true,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           physics: const ScrollPhysics(),
//                           itemCount: _cometChatController.messagesList.length,
//                           itemBuilder: (context, index) {
//                             BaseMessage message =
//                                 _cometChatController.messagesList[index];

//                             if (message is TextMessage) {
//                               final sender = message.sender as User;

//                               if (sender.uid == _cometChatController.uid) {
//                                 return messageTileRight(message.text);
//                               } else {
//                                 return messageTileLeft(message.text);
//                               }
//                               // return ListTile(
//                               //   title: Text(
//                               //     message.text,
//                               //     textAlign:
//                               //         sender.uid == _cometChatController.uid
//                               //             ? TextAlign.right
//                               //             : TextAlign.left,
//                               //   ),
//                               // );
//                             } else {
//                               return const ListTile(
//                                 title: Text('message deleted.'),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: <Widget>[
//                           InkWell(
//                             onTap: () async {
//                               await pickSelectedImageForChat();
//                               print(_cometChatController.selectedImageListChat);
//                               print(_cometChatController
//                                   .selectedImageListChat[0].path);

//                               print("object");
//                             },
//                             child: const Icon(Icons.attachment),
//                           ),
//                           Expanded(
//                             child: TextField(
//                               controller: chatController,
//                               onChanged: (value) {
//                                 // messageText = value;
//                               },
//                               decoration: const InputDecoration(
//                                 hintText: 'Enter your message...',
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.send),
//                             onPressed: () {
//                               TextMessage textMessage = TextMessage(
//                                 sender: User(
//                                   name: _cometChatController.name,
//                                   uid: _cometChatController.uid,
//                                 ),
//                                 text: chatController.text,
//                                 receiverUid: dataGetx["uid"],
//                                 receiverType: dataGetx["isUser"]
//                                     ? CometChatConversationType.user
//                                     : CometChatConversationType.group,
//                                 type: CometChatMessageType.text,
//                               );
//                               _cometChatController.messagesList
//                                   .add(textMessage);

//                               chatController.clear();
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     CometChat.removeMessageListener('listenerId');
//     super.dispose();
//   }

//   @override
//   void onTextMessageReceived(TextMessage textMessage) {
//     print("object!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//     print(textMessage);
//     _cometChatController.messagesList.add(textMessage);
//   }

//   @override
//   void onMediaMessageReceived(MediaMessage mediaMessage) {}

//   @override
//   void onCustomMessageReceived(CustomMessage customMessage) {}

//   @override
//   void onMessageEdited(BaseMessage message) {}

//   @override
//   void onMessageDeleted(BaseMessage message) {}

//   @override
//   void onTypingStarted(TypingIndicator typingIndicator) {}

//   @override
//   void onTypingEnded(TypingIndicator typingIndicator) {}
// }

// Widget messageTileRight(String title) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children: [
//       Container(
//         margin: const EdgeInsets.only(right: 12),
//         // child: Text(
//         //   formatFirestoreTimestamp(docs[i]['createdAt'] ?? Timestamp.now()),
//         //   style: const TextStyle(fontSize: 12),
//         // ),
//       ),
//       const SizedBox(height: 4),
//       Container(
//         // margin: EdgeInsets.only(left: screenWidth / 2, right: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 227, 87, 69),
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//         ),
//         child: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             height: 1.4,
//           ),
//         ),
//       ),
//       const SizedBox(height: 12),
//     ],
//   );
// }

// Widget messageTileLeft(String title) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         margin: const EdgeInsets.only(right: 12),
//         // child: Text(
//         //   formatFirestoreTimestamp(docs[i]['createdAt'] ?? Timestamp.now()),
//         //   style: const TextStyle(fontSize: 12),
//         // ),
//       ),
//       const SizedBox(height: 4),
//       Container(
//         // margin: EdgeInsets.only(left: screenWidth / 2, right: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 215, 229, 244),
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//         ),
//         child: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             height: 1.4,
//           ),
//         ),
//       ),
//       const SizedBox(height: 12),
//     ],
//   );
// }
