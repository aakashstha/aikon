import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/firebase/auth_service.dart';
import 'package:aikon/firebase/offer_service.dart';
import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/model/channel_model.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:aikon/screens/others/favourite.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferForYou extends StatefulWidget {
  const OfferForYou({super.key});

  @override
  State<OfferForYou> createState() => _OfferForYouState();
}

class _OfferForYouState extends State<OfferForYou> {
  final TabBarController _tabBarController = Get.put(TabBarController());
  final OfferController _offerController = Get.put(OfferController());
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    _offerController.loadingOtherOffers.value = true;
    await FirebaseOfferService.getAllOtherOffers();
    await FirebaseAuthService.getAllChannels();
    await FirebaseAuthService.getUserInfo();

    _offerController.loadingOtherOffers.value = false;
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Select Channel",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: [
                                // ...List.generate(
                                //     _authController.channelList.length,
                                //     (index) {
                                //   ChannelModel channel =
                                //       _authController.channelList[index];

                                //   bool isChannel = _authController
                                //       .user.value.subChannels!
                                //       .contains(_authController
                                //           .channelList[index].id);
                                //   String title = channel.title;
                                //   int channelId = channel.id;

                                //   if (isChannel) {
                                //     return selectedChannel(title, channelId);
                                //   }
                                //   return const SizedBox();
                                // }),
                              ],
                            ),
                          ),

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
                                  value:
                                      _offerController.toggleStateIsSell.value,
                                  onToggle: (value) async {
                                    _offerController.toggleStateIsSell.value =
                                        value;

                                    _offerController.loadingOtherOffers.value =
                                        true;
                                    await FirebaseOfferService
                                        .getAllOtherOffers();
                                    _offerController.loadingOtherOffers.value =
                                        false;
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
                                onPressed: () {
                                  Get.to(() => FavouriteListing());
                                },
                                icon: const Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.archive),
                              ),
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

  Widget selectedChannel(String title, int channelId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Obx(() {
        bool isChannelContains =
            _offerController.selectedChannelId.contains(channelId);

        return InkWell(
          onTap: () {
            if (isChannelContains) {
              _offerController.selectedChannelId.remove(channelId);
            } else {
              _offerController.selectedChannelId.add(channelId);
            }

            print(channelId);
            print(title);
            print(_offerController.selectedChannelId);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color:
                  isChannelContains ? AppColors.subtitleGrey : AppColors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.timeGrey,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(width: 2),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget addOffers(OfferModel offer) {
    return Dismissible(
      // key: UniqueKey(),
      key: Key(offer.id!),
      onDismissed: (direction) async {
        print(direction);
        // swipe from right to left will make it favourite
        // favourite
        if (direction == DismissDirection.endToStart) {
          _authController.favouriteIdList.add(offer.id!);
          _offerController.otherOffersListings.remove(offer);

          await FirebaseAuthService.updateFavouriteAndArchive(
              isFavourite: true);
          // archive
        } else if (direction == DismissDirection.startToEnd) {
          _authController.archiveIdList.add(offer.id!);
          await FirebaseAuthService.updateFavouriteAndArchive(
              isFavourite: false);
          _offerController.otherOffersListings.remove(offer);
        }

        print(_authController.favouriteIdList);
        print(_authController.archiveIdList);
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
                            "${offer.country} > ${offer.city} > David Campbell",
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
      ),
    );
  }
}
