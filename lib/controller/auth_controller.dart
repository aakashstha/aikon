import 'package:aikon/model/channel_model.dart';
import 'package:aikon/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  // used in all authentication buttons
  var loading = false.obs;
  var loadingTabBarNavigation = false.obs;
  var loadingHomeChannel = false.obs;

  String phoneNumber = '';
  String smsCode = '';

  // User Info
  // for storing user sub channels and used for posing in firebase
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  var profilePic = XFile("").obs;
  String urlProfilePic = "";
  List<ChannelModel> allChannelList = [];
  List<Map<String, dynamic>> subChannels = [];
  // favourite and archive
  List<String> favouriteIdList = [];
  List<String> archiveIdList = [];

  // for storing user info and displaying from server
  var user = UserModel().obs;
}
