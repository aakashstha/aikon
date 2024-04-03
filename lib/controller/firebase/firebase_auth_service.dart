import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Phone Number = +9779824968839
// OTP = 123456

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthController _authController = Get.find<AuthController>();

  static String verifyId = '';
  int resendToken = 0;

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

  static Future<void> verifyOTP({required String smsCode}) async {
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
    } catch (e) {
      print(e);
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
}
