import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/firebase_authentication.dart';
import 'package:aikon/controller/firebase_crud_controller.dart';
import 'package:aikon/controller/login_controller.dart';
import 'package:aikon/screens/authentication/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // InkWell(
              //   child: const Text(
              //     "Send OTP",
              //     style: TextStyle(fontSize: 30),
              //   ),
              //   onTap: () {
              //     _firebaseAuth.sendOTP();
              //   },
              // ),
              // const SizedBox(height: 50),
              // InkWell(
              //   child: const Text(
              //     "verify OTP",
              //     style: TextStyle(fontSize: 30),
              //   ),
              //   onTap: () {
              //     _firebaseAuth.verifyOTP();
              //   },
              // ),

              const Text(
                "Enter your phone number",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text("We need your phone number to verify your account."),
              const SizedBox(height: 10),
              // InternationalPhoneNumberInput widget for phone number input

              InternationalPhoneNumberInput(
                initialValue: PhoneNumber(isoCode: 'NP'),
                onInputChanged: (PhoneNumber number) {
                  _loginController.phoneNumber = number.phoneNumber!;
                  print(number.phoneNumber!);
                },
                // Callback for when the input is validated
                onInputValidated: (bool value) {
                  // You can perform additional validation here if needed
                },
                // Configuration for the country selector
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                ),
                // Ignore blank input
                ignoreBlank: false,
                // Auto-validation mode
                autoValidateMode: AutovalidateMode.onUserInteraction,
                // Style for the country selector
                selectorTextStyle: TextStyle(color: Colors.black),
                // Initial value for the phone number input
                // initialValue: _phoneNumber,

                // Controller for the text field
                textFieldController: TextEditingController(),
                // Decoration for the input field
                inputDecoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                // Format input (e.g., adding spaces between digits)
                formatInput: false,
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    print("object");
                    Get.to(OTPScreen());
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
    );
  }
}
