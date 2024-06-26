import 'dart:math';

import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/model/channel_model.dart';
import 'package:aikon/utilities/snackbar.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Phone Number = +9779824968839
// OTP = 123456

final AuthController _authController = Get.find<AuthController>();

class FirebaseAuthService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String userCollection = "users";
  static String channelCollection = "channels";
  // used while sending OTP and it's verification
  static String verificationIdHolder = '';
  static int resendTokenHolder = 0;

  static Future<void> sendOTP({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showSnackBar(
                "The provided phone number is not valid. Please input a valid phone number and try again.");
            return;
          }
          showSnackBar("Something went wrong please try again later");
        },
        codeSent: (String verificationId, int? resendToken) async {
          verificationIdHolder = verificationId;
          resendTokenHolder = resendToken!;

          print(verificationId);
          print(resendTokenHolder);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  static Future verifyOTP({required String smsCode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIdHolder, smsCode: smsCode);

      var response = await _firebaseAuth.signInWithCredential(credential);
      var firebaseToken = await response.user!.getIdToken();

      String token = firebaseToken!;
      StorageGetX.writeFirebaseToken(token);

      return true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        return e;
      }

      print("Error: $e");
      return false;
    }
  }

  // Add User at authentication
  static Future<void> createUser() async {
    var userData = {
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "phoneNum": FirebaseAuth.instance.currentUser!.phoneNumber,
      "verified": "user_info",
      "fullName": "",
      "username": "",
      "profilePic": "",
      "subChannels": [],
      "favourites": [],
      "archives": [],
      "createdAt": FirebaseAuth.instance.currentUser!.metadata.creationTime,
    };

    try {
      await db
          .collection(userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userData);

      print("User Added");
    } catch (e) {
      print("Failed to Add User:  $e");
    }
  }

  // Update User at authentication
  static Future<void> updateUser(String verified) async {
    late Map<String, dynamic> userData;
    if (verified == "user_info") {
      userData = {
        "verified": "subscribed_channel",
        "fullName": _authController.fullNameController.text,
        "username": _authController.userNameController.text,
        "profilePic": _authController.urlProfilePic,
      };
    } else if (verified == "subscribed_channel") {
      userData = {
        "verified": "completed",
        "subChannels": _authController.subChannels,
      };
    }

    try {
      await db
          .collection(userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(userData);

      print("User Updated");
    } catch (e) {
      print("Failed to Update User:  $e");
    }
  }

  // Generate Username at authentication
  static Future<void> generateUsername() async {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    var uniqueUsername = String.fromCharCodes(Iterable.generate(
      6,
      (_) => chars.codeUnitAt(
        random.nextInt(chars.length),
      ),
    ));

    print(uniqueUsername);

    try {
      // if size is 0 then username doesnot exist
      // if size is >= 1 then username exist
      var response = await db
          .collection(userCollection)
          .where("username", isEqualTo: uniqueUsername)
          .get();
      print(response);
      if (response.size == 0) {
        _authController.userNameController.text = uniqueUsername;
      } else {
        generateUsername();
      }

      print("Username Generated");
    } catch (e) {
      print("Failed to Generate Username:  $e");
    }
  }

  static Future<void> getUserInfo() async {
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      _authController.user.value.userId = userSnapshot["userId"];
      _authController.user.value.phoneNum = userSnapshot["phoneNum"];
      _authController.user.value.verified = userSnapshot['verified'];
      _authController.user.value.fullName = userSnapshot['fullName'];
      _authController.user.value.username = userSnapshot['username'];
      _authController.user.value.profilePic = userSnapshot['profilePic'];
      _authController.user.value.subChannels =
          List<Map<String, dynamic>>.from(userSnapshot['subChannels']);
      _authController.user.value.favourites =
          List<String>.from(userSnapshot['favourites']);
      _authController.user.value.archives =
          List<String>.from(userSnapshot['archives']);
      _authController.user.value.createdAt = userSnapshot['createdAt'];

      // for adding, removing and posting in firebase
      _authController.subChannels =
          List<Map<String, dynamic>>.from(userSnapshot["subChannels"]);

      _authController.favouriteIdList =
          List<String>.from(userSnapshot["favourites"]);
      _authController.archiveIdList =
          List<String>.from(userSnapshot["archives"]);

      print("Getting User Info Done");
    } catch (e) {
      print("Failed to get User:  $e");
    }
  }

  // Get All Channels List to Display
  static Future<void> getAllChannels() async {
    _authController.allChannelList.clear();

    try {
      var channelSnapshot = await db.collection(channelCollection).get();

      for (var doc in channelSnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        data["id"] = int.parse(doc.id);

        _authController.allChannelList.add(ChannelModel.fromJson(data));
      }

      print("Getting All Channel List Done");
    } catch (e) {
      print("Failed to get all Channel List:  $e");
    }
  }

  // Update Subscribed Channels
  static Future<void> updateUserSubscribedChannels() async {
    Map<String, dynamic> userData = {
      "subChannels": _authController.subChannels,
    };

    try {
      await db
          .collection(userCollection)
          .doc(_authController.user.value.userId)
          .update(userData);

      print("User Subscribed Channels Updated");
    } catch (e) {
      print("Failed to Update User Subscribed Channels:  $e");
    }
  }

  // Update Favourite and Archive
  static Future<void> updateUserFavouriteAndArchive(
      {required bool isFavourite}) async {
    late Map<String, dynamic> userData;
    if (isFavourite) {
      userData = {
        "favourites": _authController.favouriteIdList,
      };
    } else {
      userData = {
        "archives": _authController.archiveIdList,
      };
    }

    try {
      await db
          .collection(userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(userData);

      print("User Favourite/Archive Lists Updated");
    } catch (e) {
      print("Failed to Update User Favourite/Archive:  $e");
    }
  }
}
