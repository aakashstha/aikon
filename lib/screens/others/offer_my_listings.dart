import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/firebase/firebase_crud_service.dart';
import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:aikon/screens/others/post_offer.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferListingsYour extends StatefulWidget {
  const OfferListingsYour({super.key});

  @override
  State<OfferListingsYour> createState() => _OfferListingsYourState();
}

class _OfferListingsYourState extends State<OfferListingsYour> {
  final TabBarController _tabBarController = Get.put(TabBarController());
  final OfferController _offerController = Get.put(OfferController());

  bool toggleState = false;

  @override
  void initState() {
    // _offerController.allOffers.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueYonder,
        title: const Text("My Listings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            InkWell(
              onTap: () async {
                await FirebaseCRUDService.getAllOffers();
                print(_offerController.allOffers.length);
              },
              child: const Text("Press Me"),
            ),
            const SizedBox(height: 20),

            // Offers List
            ...List.generate(
              _offerController.allOffers.length,
              (index) {
                OfferModel offer = _offerController.allOffers[index];

                return addOffers(offer);
                // return Text("hey");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tabBarController.isAddOfferButton.value = true;
          Get.to(() => AddOffer());
        },
        backgroundColor: AppColors.blueYonder,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
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
                    color: AppColors.wantToSell,
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
