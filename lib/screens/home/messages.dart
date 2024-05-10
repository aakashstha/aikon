import 'package:aikon/cometchat/cometchat_service.dart';
import 'package:aikon/controller/cometchat_controller.dart';
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
    // initialize();
  }

  void initialize() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CometChatService.navigateToConversationsWithMessagesScreen(
          context: context),
    );
  }
}
