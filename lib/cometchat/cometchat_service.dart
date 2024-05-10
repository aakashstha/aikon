import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:aikon/cometchat/cometchat_constants.dart';
import 'package:aikon/controller/cometchat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _cometChatController = Get.put(CometChatController());

class CometChatService {
  static Future<void> initialise() async {
    try {
      String region = CometChatConstants.region;
      String appId = CometChatConstants.appId;
      String authKey = CometChatConstants.authKey;

      UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
            ..subscriptionType = CometChatSubscriptionType.allUsers
            ..autoEstablishSocketConnection = true
            ..region = region
            ..appId = appId
            ..authKey = authKey
            ..callingExtension = CometChatCallingExtension())
          .build();

      CometChatUIKit.init(
          uiKitSettings: uiKitSettings,
          onSuccess: (String successMessage) {
            debugPrint(
                "Initialization completed successfully  $successMessage");
          },
          onError: (CometChatException e) {
            debugPrint("Initialization failed with exception: ${e.message}");
          });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> createUser() async {
    try {
      User user = User(uid: "hamronepla_ma12", name: "Nepal_India");

      await CometChatUIKit.createUser(user, onSuccess: (User user) {
        debugPrint("User created successfully ${user.name}");
      }, onError: (CometChatException e) {
        debugPrint("Creating new user failed with exception: ${e.message}");
      });
    } catch (e) {
      print(e);
    }
  }

// If you are try to render any component from our UI Kit before CometChat is initialised and a user has
// been logged in you will encounter errors, so please ensure doing them sequentially.
  static Future<void> login() async {
    try {
      String uId = "aakash";

      // final user = await CometChat.getLoggedInUser();

      await CometChatUIKit.login(uId, onSuccess: (User user) {
        debugPrint("User logged in successfully  ${user.name}");
      }, onError: (CometChatException e) {
        debugPrint("Login failed with exception: ${e.message}");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> logout() async {
    try {
      await CometChatUIKit.logout(onSuccess: (String msg) {
        debugPrint("user logged out successfully: $msg");
      }, onError: (error) {
        debugPrint("error while logging out: ${error.message}");
      });
    } catch (e) {
      print(e);
    }
  }

  // from SDK
  static Future<void> createGroup({
    required String guid,
    required String groupName,
    required String memberUid,
    required String memberName,
  }) async {
    try {
      String groupType = CometChatGroupType.private;

      // group Id
      Group group = Group(guid: guid, name: groupName, type: groupType);

      await CometChat.createGroup(
          group: group,
          onSuccess: (Group group) {
            debugPrint("Group Created Successfully : $group ");
            addMember(guid, memberUid, memberName);
          },
          onError: (CometChatException e) {
            debugPrint("Group Creation failed with exception: ${e.message}");
          });
    } catch (e) {
      print(e);
    }
  }

  // from SDK
  static Future<void> addMember(
      String guid, String memberUid, String memberName) async {
    try {
      List<GroupMember> groupMembers = [];
      GroupMember firstMember = GroupMember.fromUid(
        scope: CometChatMemberScope.participant,
        uid: memberUid,
        name: memberName,
      );

      groupMembers = [firstMember];

      await CometChat.addMembersToGroup(
          guid: guid,
          groupMembers: groupMembers,
          onSuccess: (Map<String?, String?> result) {
            debugPrint("Group Member added Successfully : $result");
          },
          onError: (CometChatException e) {
            debugPrint(
                "Group Member addition failed with exception: ${e.message}");
          });
    } catch (e) {
      print(e);
    }
  }

  // CometChat Messages Screen
  static void navigateToChatScreen({
    required BuildContext context,
    required String guid,
    required String groupName,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CometChatMessages(
          detailsConfiguration:
              DetailsConfiguration(addMemberConfiguration: null),
          group: Group(
            guid: guid,
            name: groupName,
            membersCount: 2,
            hasJoined: true,
            type: GroupTypeConstants.private,
          ),
        ),
      ),
    );
  }

  // CometChat Conversation Screen
  static Widget navigateToConversationsWithMessagesScreen({
    required BuildContext context,
  }) {
    return CometChatConversationsWithMessages(
      conversationsConfiguration: ConversationsConfiguration(
        showBackButton: false,
        title: "Your Chats",
        disableSoundForMessages: true,
        appBarOptions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    createNewChat(context);
                  },
                  icon: const Icon(Icons.message),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  onPressed: () {
                    // createNewGroup(context);
                  },
                  icon: const Icon(Icons.group_add),
                ),
              ],
            ),
          ),
        ],
      ),
      messageConfiguration: const MessageConfiguration(
        disableSoundForMessages: true,
        hideDetails: true,
        messageComposerConfiguration:
            MessageComposerConfiguration(disableSoundForMessages: true),
        messageHeaderConfiguration: MessageHeaderConfiguration(
          statusIndicatorStyle: StatusIndicatorStyle(),
        ),
      ),
    );
  }

  static void createNewChat(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CometChatUsersWithMessages()));
  }
}
