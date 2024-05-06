import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:get/get.dart';

class CometChatController extends GetxController {
  var loadingMessages = false.obs;
  var loadingChats = false.obs;

  String name = "";
  String uid = "";
  List<Conversation> conversationsList = [];
  var messagesList = <BaseMessage>[].obs;
}
