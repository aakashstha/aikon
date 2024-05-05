import 'package:aikon/cometchat/cometchat_service.dart';
import 'package:aikon/controller/cometchat_controller.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _cometChatController = Get.put(CometChatController());

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State with MessageListener {
  TextEditingController chatController = TextEditingController();
  late Map dataGetx;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    _cometChatController.loadingChats.value = true;
    CometChat.addMessageListener('_listenerId', this);

    dataGetx = Get.arguments;
    print(dataGetx["uid"]);
    await CometChatService.fetchMessages(dataGetx["uid"]);
    _cometChatController.loadingChats.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Obx(
        () => _cometChatController.loadingChats.value
            ? circularCenterScreenIndicator()
            : Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: _cometChatController.messagesList.length,
                        itemBuilder: (context, index) {
                          BaseMessage message =
                              _cometChatController.messagesList[index];
                          if (message is TextMessage) {
                            //
                            String user = message.receiverUid;
                            return ListTile(
                              title: Text(
                                message.text,
                                textAlign: user == "aaron"
                                    ? TextAlign.right
                                    : TextAlign.left,
                              ),
                            );
                          } else {
                            return const ListTile(
                              title: Text('message deleted.'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: chatController,
                            onChanged: (value) {
                              // messageText = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter your message...',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            TextMessage textMessage = TextMessage(
                              text: chatController.text,
                              receiverUid: "aaron",
                              receiverType: CometChatConversationType.user,
                              type: CometChatMessageType.text,
                            );
                            _cometChatController.messagesList.add(textMessage);

                            CometChatService.sendMessage(
                                dataGetx["uid"], chatController.text);

                            chatController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    CometChat.removeMessageListener('listenerId');
    super.dispose();
  }

  @override
  void onTextMessageReceived(TextMessage textMessage) {
    print("object!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(textMessage);
    _cometChatController.messagesList.add(textMessage);
  }

  @override
  void onMediaMessageReceived(MediaMessage mediaMessage) {}

  @override
  void onCustomMessageReceived(CustomMessage customMessage) {}

  @override
  void onMessageEdited(BaseMessage message) {}

  @override
  void onMessageDeleted(BaseMessage message) {}

  @override
  void onTypingStarted(TypingIndicator typingIndicator) {}

  @override
  void onTypingEnded(TypingIndicator typingIndicator) {}
}
