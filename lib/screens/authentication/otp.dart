import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/firebase/firebase_auth_service.dart';
import 'package:aikon/controller/firebase/firebase_crud_service.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/screens/authentication/user_info.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:aikon/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Verify your phone number",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                const Text(
                    "Enter the 6-digit code we sent by SMS to +9779824968839"),
                const SizedBox(height: 10),
                Pinput(
                  length: 6,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return Validator.validateEmpty(val, "OTP");
                    } else if (val.length < 6) {
                      return "otp";
                    }
                    return "";
                  },
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blueYonder),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onCompleted: (value) {
                    _authController.smsCode = value;
                    print(value);
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      // if (_formKey.currentState!.validate()) {
                      await FirebaseAuthService.verifyOTP(
                          smsCode: _authController.smsCode);
                      // Get.to(() => UserInfo());
                      // }
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
                      child: Text("Next"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
