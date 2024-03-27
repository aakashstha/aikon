import 'dart:ffi';

import 'package:aikon/model/offer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneNumber = '';

  void sendOTP() async {}
}
