import 'dart:io';

import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/firebase/firebase_auth_service.dart';
import 'package:aikon/controller/firebase/firebase_offer_service.dart';
import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:aikon/screens/others/add_offer.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:aikon/utilities/pick_images.dart';
import 'package:country_flags/country_flags.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class OfferForYou extends StatefulWidget {
  const OfferForYou({super.key});

  @override
  State<OfferForYou> createState() => _OfferForYouState();
}

class _OfferForYouState extends State<OfferForYou> {
  final TabBarController _tabBarController = Get.put(TabBarController());
  final OfferController _offerController = Get.put(OfferController());
  bool toggleState = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await FirebaseCRUDService.getAllOtherOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _offerController.loadingOtherOffers.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    // top section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          // Testing Purposes buttons

                          // TextButton(
                          //   onPressed: () async {
                          //     await FirebaseAuthService.getUserInfo();

                          //     // var a1 = await StorageGetX.readFirebaseToken();
                          //     // print(a1);
                          //     // // new token every time
                          //     // final user = FirebaseAuth.instance.currentUser;
                          //     // var a = await user!.getIdToken();
                          //     // var b = user.refreshToken;
                          //     // print(a);
                          //     // print(b);
                          //     // print("object");
                          //   },
                          //   style: TextButton.styleFrom(
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: AppColors.blueYonder,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(0),
                          //     ),
                          //     textStyle: const TextStyle(
                          //       fontWeight: FontWeight.w700,
                          //     ),
                          //   ),
                          //   child: const Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: 28),
                          //     child: Text("get token"),
                          //   ),
                          // ),

                          TextFormField(
                            decoration: InputDecoration(
                              prefix: const SizedBox(width: 2),
                              filled: true,
                              fillColor: AppColors.searchBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search",
                              suffixIcon: const Icon(Icons.search),
                              suffixIconColor: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "WTB",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.wantToBuy,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
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
                                    // setState(() {
                                    //   toggleState = value;
                                    // });
                                  },
                                ),
                              ),
                              Text(
                                "WTS",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.wantToSell,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.archive)),
                            ],
                          ),
                          const Divider(
                            color: AppColors.searchBackground,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Offers List
                    ...List.generate(
                      _offerController.otherOffersListings.length,
                      (index) {
                        print(_offerController.otherOffersListings.length);
                        OfferModel offer =
                            _offerController.otherOffersListings[index];

                        return addOffers(offer);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

Widget addOffers(OfferModel offer) {
  return Column(
    children: [
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: offer.isSell
                        ? AppColors.wantToSell
                        : AppColors.wantToBuy,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      offer.isSell ? "WTS" : "WTB",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ClipOval(
                  clipBehavior: Clip.hardEdge,
                  child: CountryFlag.fromCountryCode(
                    'AT',
                    height: 35,
                    width: 35,
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    offer.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.subtitleGrey,
                      height: 1,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    offer.description,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        "${offer.countryName} > ${offer.cityName} > David Campbell",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subtitleGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // time column
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "9:44 PM",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.timeGrey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      const Divider(
        color: AppColors.subtitleGrey,
        thickness: 1,
      ),
    ],
  );
}
