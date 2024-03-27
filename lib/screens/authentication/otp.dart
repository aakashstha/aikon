import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/firebase_authentication.dart';
import 'package:aikon/controller/firebase_crud_controller.dart';
import 'package:aikon/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                  print(value);
                },
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
                    child: Text("Proceed"),
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
