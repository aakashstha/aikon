import 'package:aikon/constants/colors.dart';
import 'package:aikon/firebase/auth_service.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:aikon/utilities/snackbar.dart';
import 'package:aikon/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                Text(
                    "Enter the 6-digit code we sent by SMS to ${_authController.phoneNumber}"),
                const SizedBox(height: 10),
                Pinput(
                  length: 6,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return Validator.validateEmpty(val, "OTP");
                    } else if (val.length < 6) {
                      return "otp";
                    }
                    return null;
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
                  onChanged: (val) {
                    _authController.smsCode = val;
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print(val);
                  },
                  // onCompleted: (value) {
                  //   _authController.smsCode = value;
                  //   print(value);
                  // },
                ),
                // const Text(
                //   "Please enter the OTP",
                //   style: TextStyle(
                //     color: Colors.red,
                //   ),
                // ),
                const Spacer(),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        if (_authController.smsCode.length >= 6) {
                          _authController.loading.value = true;
                          var response = await FirebaseAuthService.verifyOTP(
                              smsCode: _authController.smsCode);

                          if (response == true) {
                            await FirebaseAuthService.createUser();
                            await FirebaseAuthService.generateUsername();
                            Get.toNamed("/UserInfo");
                          } else if (response.code ==
                              "invalid-verification-code") {
                            showSnackBar(
                                "The OTP entered is incorrect. Please enter correct OTP or try to resend the OTP");
                          } else if (response.code == "session-expired") {
                            showSnackBar(
                                "The OTP code has been expired. Please try to resend the OTP.");
                          } else {
                            showSnackBar(
                                "Something went wrong please try again later");
                          }
                          _authController.loading.value = false;
                        }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
