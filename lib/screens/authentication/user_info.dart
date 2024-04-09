import 'dart:developer';

import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/controller/firebase/firebase_auth_service.dart';
import 'package:aikon/screens/authentication/select_channel.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/screens/widgets/text_field.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:aikon/utilities/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
                TextButton(
                  onPressed: () async {
                    // var a1 = await StorageGetX.readFirebaseToken();
                    // print(a1);
                    // // new token every time
                    // final user = FirebaseAuth.instance.currentUser;
                    // var a = await user!.getIdToken();
                    // print(a);
                    // print("object");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.blueYonder,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text("get token"),
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
                  padding: const EdgeInsets.only(top: 15, bottom: 40),
                  child: customTextField(
                    hintText: "Username",
                    controller: _authController.userNameController,
                    prefixWidth: 5,
                    validate: (val) {
                      return Validator.validateEmpty(val!, "Username");
                    },
                  ),
                ),
                const Center(
                  child: CircleAvatar(
                    backgroundColor: AppColors.subtitleGrey,
                    radius: 50,
                    child: Icon(Icons.upload),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Upload your profile image here",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: 80),

                // Next Button
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueYonder,
                      shape: const BeveledRectangleBorder(),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await FirebaseAuthService.updateUser("user_info");
                        Get.to(() => SelectChannel());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
