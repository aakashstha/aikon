import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/controller/firebase/firebase_auth_service.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectChannel extends StatefulWidget {
  const SelectChannel({super.key});

  @override
  State<SelectChannel> createState() => _SelectChannelState();
}

class _SelectChannelState extends State<SelectChannel> {
  final AuthController _authController = Get.put(AuthController());
  bool showErrorText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            Text(
              "You must subscribe to some channel to get started.",
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Subscribe  channels",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.channelSubtitle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            addChannel("Mobile phones", "mostly new, oem, carrier unlocked",
                "mobile_phones"),
            const SizedBox(height: 10),
            addChannel("Computer Electronics",
                "mostly new, oem, carrier unlocked", "computer_electronics"),
            const SizedBox(height: 10),
            addChannel("Laptop", "mostly new, oem, carrier unlocked", "laptop"),
            const SizedBox(height: 10),
            addChannel("Accessories", "mostly new, oem, carrier unlocked",
                "accessories"),
            const SizedBox(height: 10),
            showErrorText
                ? const Text(
                    "You must select atleast one channel",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
            const Spacer(),

            // Done Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueYonder,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () async {
                    print(_authController.channel);
                    if (_authController.channel.isEmpty) {
                      setState(() {
                        showErrorText = true;
                      });
                      return;
                    }
                    _authController.loading.value = true;

                    await FirebaseAuthService.updateUser("subscribed_channel");
                    _authController.loading.value = false;

                    Get.offAll(() => TabBarNavigation());
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget addChannel(String channel, String subtitle, String postChannel) {
    bool toggleState = false;
    return StatefulBuilder(
      builder: (BuildContext ctx, StateSetter setState) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FlutterSwitch(
                height: 30.0,
                width: 60.0,
                inactiveSwitchBorder: Border.all(
                  color: AppColors.subtitleGrey,
                  width: 4.0,
                ),
                inactiveColor: AppColors.white,
                inactiveToggleColor: AppColors.subtitleGrey,
                activeSwitchBorder: Border.all(
                  color: AppColors.blueYonder,
                  width: 4.0,
                ),
                activeColor: AppColors.white,
                activeToggleColor: AppColors.blueYonder,
                value: toggleState,
                onToggle: (value) {
                  print(value);
                  setState(() {
                    toggleState = value;
                  });
                  if (value) {
                    _authController.channel.add(postChannel);
                  } else {
                    _authController.channel.remove(postChannel);
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  channel,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    height: 1.2,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.channelSubtitle,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
