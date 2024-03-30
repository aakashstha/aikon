import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/screens/widgets/dropdown_channel.dart';
import 'package:aikon/screens/widgets/text_field.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({super.key});

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  final TabBarController _tabBarController = Get.put(TabBarController());
  bool toggleState = false;
  bool checkAnonymously = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 5),
            // top section
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  _tabBarController.isAddOfferButton.value = false;
                },
                icon: Icon(Icons.close),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Post an offer",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.channelSubtitle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Buying",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.wantToBuy,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FlutterSwitch(
                    height: 30.0,
                    width: 60.0,
                    toggleSize: 20.0,
                    inactiveSwitchBorder: Border.all(
                      color: AppColors.wantToBuy,
                      width: 3.0,
                    ),
                    inactiveColor: AppColors.white,
                    inactiveToggleColor: AppColors.wantToBuy,
                    activeSwitchBorder: Border.all(
                      color: AppColors.wantToSell,
                      width: 3.0,
                    ),
                    activeColor: AppColors.white,
                    activeToggleColor: AppColors.wantToSell,
                    value: toggleState,
                    onToggle: (value) {
                      setState(() {
                        toggleState = value;
                      });
                    },
                  ),
                ),
                Text(
                  "Selling",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.wantToSell,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(
              color: AppColors.searchBackground,
              thickness: 1,
            ),
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.searchBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  customTextField(
                    hintText: "Title",
                    controller: TextEditingController(),
                  ),
                  customTextField(
                    hintText: "Subtitle",
                    controller: TextEditingController(),
                  ),
                  customTextField(
                    hintText: "Description....",
                    controller: TextEditingController(),
                    maxLine: 5,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Country and City
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 7, left: 10, right: 10, bottom: 7),
                    decoration: BoxDecoration(
                      color: AppColors.searchBackground,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: customTextField(
                      hintText: "Country",
                      controller: TextEditingController(),
                      textFieldTopHeight: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 7, left: 10, right: 10, bottom: 7),
                    decoration: BoxDecoration(
                      color: AppColors.searchBackground,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: customTextField(
                      hintText: "City",
                      controller: TextEditingController(),
                      textFieldTopHeight: 0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 34, vertical: 34),
                  decoration: BoxDecoration(
                    color: AppColors.searchBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.upload),
                      Text("Upload"),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 34, vertical: 34),
                  decoration: BoxDecoration(
                    color: AppColors.searchBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.upload),
                      Text("Upload"),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 34, vertical: 34),
                  decoration: BoxDecoration(
                    color: AppColors.searchBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.upload),
                      Text("Upload"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Private",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.channelSubtitle,
                  ),
                ),
                const SizedBox(width: 10),
                FlutterSwitch(
                  height: 25.0,
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
              ],
            ),
            const SizedBox(height: 10),
            DropdownButtonForChannel(),

            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.blueYonder,
                  checkColor: AppColors.white,
                  value: checkAnonymously,
                  onChanged: (value) {
                    setState(() {
                      checkAnonymously = value!;
                    });
                  },
                ),
                Text(
                  "Post Anonymously",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            // Post Button
            TextButton(
              onPressed: () async {
                // if (_formKeyChangePassword.currentState!.validate()) {

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child:
                    // Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           const Text("Changing..."),
                    //           const SizedBox(width: 20),
                    //           circularIndicator()
                    //         ],
                    //       )
                    const Text("Post Offer"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
