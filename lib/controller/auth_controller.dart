import 'package:aikon/model/channel_model.dart';
import 'package:aikon/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  // used in all authentication buttons
  var loading = false.obs;
  var loadingTabBarNavigation = false.obs;
  var loadingChannel = false.obs;

  var loadingUserInfo = false.obs;

  String phoneNumber = '';
  String smsCode = '';

  // User Info
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  var profilePic = XFile("").obs;
  String urlProfilePic = "";
  List<ChannelModel> channelList = [];
  List<int> channelsId = [];

  // for storing user info from server
  var user = UserModel().obs;

  // favourite and archive
  List<String> favouriteIdList = [];
  List<String> archiveIdList = [];
}
