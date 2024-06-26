import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/firebase/auth_service.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Channel extends StatefulWidget {
  const Channel({super.key});

  @override
  State<Channel> createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    _authController.loadingHomeChannel.value = true;
    await FirebaseAuthService.getAllChannels();
    // await FirebaseAuthService.getUserSubscribedChannelsId();
    _authController.loadingHomeChannel.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _authController.loadingHomeChannel.value
            ? circularCenterScreenIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    const SizedBox(height: 40),
                    Column(
                      children: [
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
                        ...List.generate(
                          _authController.allChannelList.length,
                          (index) {
                            var channel = _authController.allChannelList[index];
                            bool toggleState = _authController.subChannels
                                .any((map) => map["id"] == channel.id);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: addChannel(channel.id, channel.title,
                                  channel.subtitle, toggleState),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget addChannel(int id, String title, String subtitle, bool toggleState) {
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
                onToggle: (value) async {
                  setState(() {
                    toggleState = value;
                  });
                  if (value) {
                    _authController.subChannels.add({"id": id, "title": title});
                  } else {
                    _authController.subChannels
                        .removeWhere((element) => element["id"] == id);
                  }
                  _authController.loadingHomeChannel.value = true;
                  await FirebaseAuthService.updateUserSubscribedChannels();
                  _authController.loadingHomeChannel.value = false;
                  print(_authController.subChannels);
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
