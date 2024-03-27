import 'dart:ffi';

import 'package:aikon/model/offer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Phone Number = +9779824968839
// OTP = 123456

class FirebaseAuthenticationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';
  int resendToken = 0;

  void sendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+9779824968839',
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
          this.verificationId = verificationId;
          this.resendToken = resendToken!;

          print("#########################################################");
          print(this.verificationId);
          print(this.resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  void verifyOTP() async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: '123456');

      var response = await _auth.signInWithCredential(phoneAuthCredential);

      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(verificationId);
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
