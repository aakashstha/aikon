import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/screens/home/channel.dart';
import 'package:aikon/screens/home/offer_for_you.dart';
import 'package:aikon/screens/others/offer_my_listings.dart';
import 'package:aikon/screens/others/add_offer.dart';
import 'package:aikon/screens/others/settings.dart';
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

enum Options { search, upload, copy, exit }

class _TabBarNavigationState extends State<TabBarNavigation> {
  var _popupMenuItemIndex = 0;
  Color _changeColorAccordingToMenuItem = Colors.red;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 3,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueYonder,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.subtitleGrey,
                radius: 20,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "John Doe",
                    style: TextStyle(fontSize: 20, color: AppColors.white),
                  ),
                  const Text(
                    "+65 9875 6345",
                    style: TextStyle(fontSize: 11, color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                print("Add Offer");
                Get.to(() => AddOffer(
                      isUpdateOffer: false,
                    ));
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
                _buildPopupMenuItem(
                    'My Listings', Icons.search, Icons.chevron_right, 0),
                _buildPopupMenuItem(
                    'Settings', Icons.settings, Icons.chevron_right, 1),
              ],
            )
          ],
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
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
          children: <Widget>[
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
            OfferForYou(),
            Channel()
          ],
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
