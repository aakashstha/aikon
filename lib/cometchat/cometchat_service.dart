import 'package:aikon/cometchat/cometchat_constants.dart';
import 'package:aikon/controller/cometchat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _cometChatController = Get.put(CometChatController());

class CometChatService {
  static Future<void> initialise() async {
    try {
      String region = CometChatConstants.region;
      String appId = CometChatConstants.appId;

      AppSettings appSettings = (AppSettingsBuilder()
            ..subscriptionType = CometChatSubscriptionType.allUsers
            ..region = region
            ..adminHost = "" //optional
            ..clientHost = "" //optional
            ..autoEstablishSocketConnection = true)
          .build();

      await CometChat.init(appId, appSettings,
          onSuccess: (String successMessage) {
        debugPrint("Initialization completed successfully  $successMessage");
      }, onError: (CometChatException excep) {
        debugPrint("Initialization failed with exception: ${excep.message}");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> register() async {
    try {
      String authKey = CometChatConstants.authKey;
      User user = User(uid: "aakash", name: "Aakash Shrestha");

      CometChat.createUser(user, authKey, onSuccess: (User user) {
        debugPrint("Create User succesful ${user}");
      }, onError: (CometChatException e) {
        debugPrint("Create User Failed with exception ${e.message}");
      });
    } catch (e) {
      print(e);
    }
  }

  // We recommend you call the CometChat login() method once your user logs into your app. The login() method needs to be called only once.
  static Future<void> login() async {
    try {
      String UID = "aakash";
      String authKey = CometChatConstants.authKey;

      final user = await CometChat.getLoggedInUser();
      if (user == null) {
        await CometChat.login(UID, authKey, onSuccess: (User user) {
          debugPrint("Login Successful : $user");
        }, onError: (CometChatException e) {
          debugPrint("Login failed with exception:  ${e.message}");
        });
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> logout() async {
    try {
      await CometChat.logout(onSuccess: (successMessage) {
        debugPrint("Logout successful with message $successMessage");
      }, onError: (CometChatException e) {
        debugPrint("Logout failed with exception:  ${e.message}");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> sendMessage(String uid, String message) async {
    try {
      String receiverID = uid;
      String messageText = message;
      String receiverType = CometChatConversationType.user;
      String type = CometChatMessageType.text;

      TextMessage textMessage = TextMessage(
          text: messageText,
          receiverUid: receiverID,
          receiverType: receiverType,
          type: type);
      CometChat.sendMessage(textMessage, onSuccess: (TextMessage message) {
        debugPrint("Message sent successfully:  $message");
      }, onError: (CometChatException e) {
        debugPrint("Message sending failed with exception:  ${e.message}");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> fetchConversation() async {
    _cometChatController.conversationsList.clear();

    try {
      ConversationsRequest conversationRequest =
          (ConversationsRequestBuilder()..limit = 50).build();

      await conversationRequest.fetchNext(
        onSuccess: (List<Conversation> conversations) {
          _cometChatController.conversationsList.addAll(conversations);

          for (var element in conversations) {
            debugPrint("Conversation : ${element.toString()}");
          }
        },
        onError: (CometChatException e) {},
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> fetchMessages(String uid) async {
    _cometChatController.messagesList.clear();

    var a = await CometChat.getLastDeliveredMessageId();

    int limit = 30;
    int lastMessageId = -1;
    String UID = uid;

    print("object");
    print(a);

    MessagesRequest messageRequest = (MessagesRequestBuilder()
          ..uid = UID
          ..limit = limit
          ..messageId = lastMessageId)
        .build();

    await messageRequest.fetchPrevious(onSuccess: (List<BaseMessage> list) {
      _cometChatController.messagesList.addAll(list);

      for (BaseMessage message in list) {
        // _cometChatController.messagesList.add(message);
        if (message is TextMessage) {
          debugPrint("Text message received successfully: $message");
        } else if (message is MediaMessage) {
          debugPrint("Media message received successfully: $message");
        }
      }
    }, onError: (CometChatException e) {
      debugPrint("Message fetching failed with exception: ${e.message}");
    });
  }
}
