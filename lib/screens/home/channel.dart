import 'package:aikon/constants/colors.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class Channel extends StatefulWidget {
  const Channel({super.key});

  @override
  State<Channel> createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  bool toggleState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Subscribed  channels",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.channelSubtitle,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                addChannel(),
              ],
            ),
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
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info,
              size: 30,
              color: AppColors.channelSubtitle,
            ),
          ),
        ],
      );
    },
  );
}
