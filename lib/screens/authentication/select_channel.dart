import 'package:aikon/constants/colors.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectChannel extends StatefulWidget {
  const SelectChannel({super.key});

  @override
  State<SelectChannel> createState() => _SelectChannelState();
}

class _SelectChannelState extends State<SelectChannel> {
  bool toggleState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 120),
            Text(
              "You must subscribe to some channel to get started.",
              style: GoogleFonts.poppins(
                  // fontSize: 16,
                  ),
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
            addChannel(),
            Spacer(),

            // Done Button
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueYonder,
                  shape: const BeveledRectangleBorder(),
                ),
                onPressed: () async {
                  Get.to(() =>TabBarNavigation());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text(
                          "Done",
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget addChannel() {
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
                setState(() {
                  toggleState = value;
                });
              },
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "mobile phones / tablets",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  height: 1.2,
                ),
              ),
              Text(
                "mostly new, oem, carrier unlocked",
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
