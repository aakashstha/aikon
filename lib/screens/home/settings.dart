import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:aikon/cometchat/cometchat_service.dart';
import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/cometchat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _cometChatController = Get.put(CometChatController());

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> list = [];
  TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              print("object");
              print(_cometChatController.uid);
            },
            child: Text("Bring all the chat"),
          ),
          TextButton(
            onPressed: () async {
              // await CometChatService.register();
              // await CometChatService.login();
              await CometChatService.logout();

              // CometChatService.fetchConversation();
              // CometChatService.sendMessage();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.blueYonder,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text("get token"),
            ),
          ),
          Text("Settings"),
          TextButton(
            onPressed: () async {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.blueYonder,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text("chat with chatting system"),
            ),
          ),
        ],
      ),
    );
  }
}
