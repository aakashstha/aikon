import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/firebase/firebase_auth_service.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/screens/authentication/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Enter your phone number",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                const Text("We need your phone number to verify your account."),
                const SizedBox(height: 10),

                // InternationalPhoneNumberInput widget for phone number input
                InternationalPhoneNumberInput(
                  // autoFocus: true,

                  countrySelectorScrollControlled: true,
                  spaceBetweenSelectorAndTextField: 0,
                  initialValue: PhoneNumber(isoCode: 'NP'),
                  onInputChanged: (PhoneNumber number) {
                    _authController.phoneNumber = number.phoneNumber!;
                    print(number.phoneNumber!);
                    print(_authController.phoneNumber);
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  textFieldController: TextEditingController(),
                  // Configuration for the country selector
                  selectorConfig: const SelectorConfig(
                    // selectorType: PhoneInputSelectorType.DIALOG,
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                    // setSelectorButtonAsPrefixIcon: true,
                    // useBottomSheetSafeArea: true,
                  ),
                  // Decoration for the input field
                  inputDecoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  // Format input (e.g., adding spaces between digits)
                  formatInput: false,
                ),

                const Spacer(),

                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await FirebaseAuthService.sendOTP(
                              phoneNumber: _authController.phoneNumber);

                          Get.to(() => OTPScreen());
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
                          ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const Text("Next"),
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
