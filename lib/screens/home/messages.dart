import 'package:aikon/cometchat/cometchat_service.dart';
import 'package:aikon/controller/cometchat_controller.dart';
import 'package:aikon/screens/others/chat.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _cometChatController = Get.put(CometChatController());

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    _cometChatController.loadingMessages.value = true;
    await CometChatService.fetchConversation();
    _cometChatController.loadingMessages.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Obx(
        () => _cometChatController.loadingMessages.value
            ? circularCenterScreenIndicator()
            : ListView.builder(
                itemCount: _cometChatController.conversationsList.length,
                itemBuilder: (context, index) {
                  final conversation =
                      _cometChatController.conversationsList[index];

                  if (conversation.conversationType == "user") {
                    final user = _cometChatController
                        .conversationsList[index].conversationWith as User;

                    Map data = {"uid": user.uid};

                    return InkWell(
                      onTap: () {
                        Get.to(() => ChatScreen(), arguments: data);
                      },
                      child: ListTile(
                        leading: user.avatar == null
                            ? const CircleAvatar(child: Text('U'))
                            : CircleAvatar(child: Image.network(user.avatar!)),
                        title: Text(user.name),
                        // subtitle: Text(user.status!),
                        subtitle: Text(conversation.conversationId!),
                        trailing: const Text("2 mins ago"),
                      ),
                    );
                  } else if (conversation.conversationType == "group") {
                    final group = _cometChatController
                        .conversationsList[index].conversationWith as Group;

                    // return Text(group.name);
                    return ListTile(
                      leading: const CircleAvatar(child: Text('G')),
                      title: Text(group.name),
                      subtitle: Text(conversation.conversationId!),
                      trailing: const Text("2 mins ago"),
                    );
                  }
                  return null;
                },
              ),
      ),
    );
  }
}
