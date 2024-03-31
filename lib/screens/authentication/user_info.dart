import 'dart:developer';

import 'package:aikon/constants/colors.dart';
import 'package:aikon/screens/authentication/select_channel.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/screens/widgets/text_field.dart';
import 'package:aikon/utilities/validator.dart';
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController abnController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  controller: firstNameController,
                  prefixWidth: 5,
                  validate: (val) {
                    return Validator.validateEmpty(val!, "First Name");
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 40),
                  child: customTextField(
                    hintText: "Username",
                    controller: emailController,
                    prefixWidth: 5,
                    validate: (val) {
                      return Validator.validateEmail(val!, "Email");
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
                const Spacer(),

                // Next Button
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueYonder,
                      shape: const BeveledRectangleBorder(),
                    ),
                    onPressed: () async {
                      Get.to(SelectChannel());
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
