import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/screens/others/add_offer.dart';
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
  bool toggleState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            // top section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star_rounded,
                          size: 30,
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
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
            addOffers()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tabBarController.isAddOfferButton.value = true;
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

Widget addOffers() {
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
                      "WTS",
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
                    "Samsung S23 Ultra 256+12",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    "3 Colors | Latam | 400 pcs",
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
                    "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been in the name all the ways me with very good guy",
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
                        "USA > Miami > David Campbell",
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
