import 'package:aikon/model/offer_model.dart';
import 'package:aikon/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  var loading = false.obs;
  var loadingUserInfo = false.obs;

  String phoneNumber = '';
  String smsCode = '';

  // User Info
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  var profilePic = XFile("").obs;
  String urlProfilePic = "";
  var channel = [].obs;

  var user = UserModel().obs;
}
