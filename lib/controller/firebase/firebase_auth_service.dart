import 'package:aikon/controller/auth_controller.dart';
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

  static String verifyId = '';
  int resendToken = 0;
  static String userCollection = "users";

  static Future<void> sendOTP({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        // forceResendingToken: controller.resendToken,
        verificationCompleted:
            (PhoneAuthCredential phoneAuthCredential) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          verifyId = verificationId;
          resendToken = resendToken!;

          print("#########################################################");
          print(verificationId);
          print(resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  static Future verifyOTP({required String smsCode}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verifyId, smsCode: smsCode);

      var response =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      var firebaseToken = await response.user!.getIdToken();
      String token = firebaseToken!;
      StorageGetX.writeFirebaseToken(token);

      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

      print(verifyId);
      print(response.user!.refreshToken);
      print(response);
      return true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        return e;
      }
      print("Error: $e");
    }
  }

  // logout the user
  static Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  // check whetehr the user is logged in or not
  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  // Add User
  static Future<void> createUser() async {
    _authController.loadingUserInfo.value = true;

    var userData = {
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "phoneNumber": FirebaseAuth.instance.currentUser!.phoneNumber,
      "verified": "user_info",
      "fullName": "",
      "username": "",
      "profilePic": "",
      "subscribedChannels": [],
      "createdAt": FirebaseAuth.instance.currentUser!.metadata.creationTime,
    };

    try {
      await db
          .collection(userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userData);

      _authController.loadingUserInfo.value = false;
      print("User Added");
    } catch (e) {
      _authController.loadingUserInfo.value = false;
      print("Failed to Add User:  $e");
    }
  }

  // Update User
  static Future<void> updateUser(String verified) async {
    _authController.loadingUserInfo.value = true;
    late Map<String, dynamic> userData;
    if (verified == "usre_info") {
      userData = {
        "verified": "subscribed_channel",
        "fullName": _authController.fullNameController.text,
        "username": _authController.userNameController.text,
        "profilePic": "",
      };
    } else if (verified == "subscribed_channel") {
      userData = {
        "verified": "completed",
        "subscribedChannels": _authController.channel,
      };
    }

    try {
      await db
          .collection(userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(userData);

      _authController.loadingUserInfo.value = false;
      print("User Updated");
    } catch (e) {
      _authController.loadingUserInfo.value = false;
      print("Failed to Update User:  $e");
    }
  }
}
