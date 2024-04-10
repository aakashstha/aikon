import 'package:aikon/controller/auth_controller.dart';
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
  // used while sending OTP and it's verification
  static String verificationIdHolder = '';
  static int resendTokenHolder = 0;

  static Future<void> sendOTP({required String phoneNumber}) async {
    _authController.loading.value = true;
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            _authController.loading.value = false;
            showSnackBar(
                "The provided phone number is not valid. Please input a valid phone number and try again.");
            return;
          }
          _authController.loading.value = false;
          showSnackBar("Something went wrong please try again later");
        },
        codeSent: (String verificationId, int? resendToken) async {
          verificationIdHolder = verificationId;
          resendTokenHolder = resendToken!;

          print(verificationId);
          print(resendTokenHolder);
          _authController.loading.value = false;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  static Future verifyOTP({required String smsCode}) async {
    _authController.loading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIdHolder, smsCode: smsCode);

      var response = await _firebaseAuth.signInWithCredential(credential);
      var firebaseToken = await response.user!.getIdToken();
      _authController.loading.value = false;

      String token = firebaseToken!;
      StorageGetX.writeFirebaseToken(token);

      return true;
    } catch (e) {
      _authController.loading.value = false;
      if (e is FirebaseAuthException) {
        return e;
      }

      print("Error: $e");
      return false;
    }
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
        "subscribedChannels": _authController.channel,
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

  static Future<void> getUserInfo() async {
    _authController.user.value.userId = FirebaseAuth.instance.currentUser!.uid;
    _authController.user.value.phoneNumber =
        FirebaseAuth.instance.currentUser!.phoneNumber;

    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        _authController.user.value.fullName = value['fullName'];
        _authController.user.value.username = value['username'];
        _authController.user.value.profilePic = value['profilePic'];
        _authController.user.value.verified = value['verified'];
        _authController.user.value.subscribedChannels =
            value['subscribedChannels'];
      });

      print("Getting User Info Done");
    } catch (e) {
      print("Failed to get User:  $e");
    }
  }
}
