import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/firebase/firebase_auth_service.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/screens/home/channel.dart';
import 'package:aikon/screens/home/offer_for_you.dart';
import 'package:aikon/screens/others/offer_my_listings.dart';
import 'package:aikon/screens/others/add_offer.dart';
import 'package:aikon/screens/others/settings.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TabBarNavigation extends StatefulWidget {
  const TabBarNavigation({super.key});

  @override
  State<TabBarNavigation> createState() => _TabBarNavigationState();
}

class _TabBarNavigationState extends State<TabBarNavigation> {
  final AuthController _authController = Get.put(AuthController());

  int _initialIndex = 3;
  Color _changeColorAccordingToMenuItem = Colors.red;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    _authController.loadingTabBarNavigation.value = true;
    await FirebaseAuthService.getUserInfo();
    _authController.loadingTabBarNavigation.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _authController.loadingTabBarNavigation.value
          ? Scaffold(
              body: Center(
              child: circularCenterScreenIndicator(),
            ))
          : DefaultTabController(
              initialIndex: _initialIndex,
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.blueYonder,
                  title: Row(
                    children: [
                      _authController.user.value.profilePic!.isEmpty
                          ? const CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.subtitleGrey,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  _authController.user.value.profilePic!,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _authController.user.value.fullName!,
                            style: const TextStyle(
                                fontSize: 20, color: AppColors.white),
                          ),
                          Text(
                            _authController.user.value.phoneNumber!,
                            style: const TextStyle(
                                fontSize: 11, color: AppColors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        print("Add Offer");
                        Get.to(() => AddOffer());
                      },
                      icon: Icon(Icons.add, color: AppColors.white),
                    ),
                    PopupMenuButton(
                      iconColor: AppColors.white,
                      onSelected: (value) {
                        print(value);
                        int val = value as int;
                        setState(() {
                          if (val == 0) {
                            // Get.toNamed("/OfferMyListing");
                            Get.to(() => OfferMyListing());
                          } else if (val == 1) {
                            // Get.toNamed("/SettingScreen");
                            Get.to(() => SettingScreen());
                          }
                        });
                      },
                      offset: Offset(0.0, AppBar().preferredSize.height),
                      itemBuilder: (ctx) => [
                        _buildPopupMenuItem('My Listings', Icons.search,
                            Icons.chevron_right, 0),
                        _buildPopupMenuItem(
                            'Settings', Icons.settings, Icons.chevron_right, 1),
                      ],
                    )
                  ],
                  bottom: const TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    labelStyle:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    labelColor: Colors.black,
                    indicatorColor: AppColors.blueYonder,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(
                          Icons.call,
                          color: AppColors.white,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.people,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        "Messages",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Offers",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.tune,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Center(
                      child: Text("It's Call Screen"),
                    ),
                    Center(
                      child: Text("It's Contact Screen"),
                    ),
                    Center(
                      child: Text("It's Messages Screen"),
                    ),
                    OfferForYou(),
                    Channel()
                  ],
                ),
              ),
            ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, IconData iconData,
      IconData trailingIconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Icon(
          //   iconData,
          //   color: Colors.black,
          // ),
          Text(title),
          const Spacer(),
          Icon(
            trailingIconData,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
