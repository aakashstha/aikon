import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/firebase/firebase_crud_service.dart';
import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/screens/others/add_offer.dart';
import 'package:aikon/screens/others/offer_individual.dart';
import 'package:aikon/screens/widgets/bottom_sheet.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferMyListing extends StatefulWidget {
  const OfferMyListing({super.key});

  @override
  State<OfferMyListing> createState() => _OfferMyListingState();
}

class _OfferMyListingState extends State<OfferMyListing> {
  final TabBarController _tabBarController = Get.put(TabBarController());
  // while not using permanent = true then the controller get deleted
  final OfferController _offerController =
      Get.put(OfferController(), permanent: true);

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await FirebaseCRUDService.getAllMyOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueYonder,
        title: const Text(
          "My Listings",
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => _offerController.loadingMyOffers.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),

                    // InkWell(
                    //   onTap: () async {
                    //     print(_offerController.myOffersListings[0].imagesList);
                    //   },
                    //   child: const Text("Press Me"),
                    // ),
                    const SizedBox(height: 20),

                    // Offers List
                    ...List.generate(
                      _offerController.myOffersListings.length,
                      (index) {
                        OfferModel offer =
                            _offerController.myOffersListings[index];

                        return addOffers(offer, index);
                        // return Text("hey");
                      },
                    ),
                  ],
                ),
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _tabBarController.isAddOfferButton.value = true;
      //     Get.to(() => AddOffer(isUpdateOffer: false));
      //   },
      //   backgroundColor: AppColors.blueYonder,
      //   child: const Icon(
      //     Icons.add,
      //     color: AppColors.white,
      //   ),
      // ),
    );
  }
}

Widget addOffers(OfferModel offer, int index) {
  return InkWell(
    onTap: () {
      Get.to(() => OfferIndividual(offer: offer));
    },
    child: Column(
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
                  InkWell(
                    onTap: () {
                      showOfferBottomSheet(index: index, offer: offer);
                    },
                    child: const Icon(
                      Icons.more_horiz,
                      color: AppColors.blueYonder,
                    ),
                  ),
                  const Spacer(),
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
    ),
  );
}
