import 'package:aikon/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  // used in all authentication buttons
  var loading = false.obs;
  var loadingTabBarNavigation = false.obs;

  var loadingUserInfo = false.obs;

  String phoneNumber = '';
  String smsCode = '';

  // User Info
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  var profilePic = XFile("").obs;
  String urlProfilePic = "";
  var channel = [].obs;

  // for storing user info from server
  var user = UserModel().obs;
}
