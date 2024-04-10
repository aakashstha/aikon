import 'dart:developer';
import 'dart:io';

import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/controller/firebase/firebase_auth_service.dart';
import 'package:aikon/controller/firebase/firebase_upload_service.dart';
import 'package:aikon/screens/authentication/select_channel.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:aikon/screens/widgets/text_field.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:aikon/utilities/pick_images.dart';
import 'package:aikon/utilities/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  String password = "";
  String businessName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                //  User Info
                const Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 50),
                  child: Text(
                    "UserInfo",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                customTextField(
                  hintText: "Full Name",
                  textCapitalization: TextCapitalization.words,
                  controller: _authController.fullNameController,
                  prefixWidth: 5,
                  validate: (val) {
                    return Validator.validateEmpty(val!, "Full Name");
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: customTextField(
                    maxLength: 15,
                    hintText: "Username",
                    controller: _authController.userNameController,
                    prefixWidth: 5,
                    validate: (val) {
                      return Validator.validateUsername(val!);
                    },
                  ),
                ),
                const Text(
                  "*We have generated a unique username for you. You can customize it.",
                ),
                const SizedBox(height: 30),
                Obx(
                  () => InkWell(
                    onTap: () async {
                      await pickProfileImage();
                    },
                    child: _authController.profilePic.value.path.isEmpty
                        ? const Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.subtitleGrey,
                              child: Icon(Icons.upload),
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.file(
                                File(_authController.profilePic.value.path),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    "Upload your profile image here",
                    style: TextStyle(),
                  ),
                ),

                const SizedBox(height: 80),

                // Next Button
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueYonder,
                        shape: const BeveledRectangleBorder(),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _authController.loading.value = true;

                          await FirebaseUploadService.uploadProfileImage();
                          await FirebaseAuthService.updateUser("user_info");

                          _authController.loading.value = false;
                          Get.to(() => SelectChannel());
                        }
                      },
                      child: _authController.loading.value
                          ? circularButtonIndicator()
                          : const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
