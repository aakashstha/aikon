import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/tabbar_controller.dart';
import 'package:aikon/screens/home/channel.dart';
import 'package:aikon/screens/home/offer_for_you.dart';
import 'package:aikon/screens/home/offer_listings_your.dart';
import 'package:aikon/screens/others/add_offer.dart';
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 3,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('TabBar Sample'),
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
                print("Setting");
              },
              icon: Icon(Icons.more_vert, color: AppColors.white),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              // labelPadding: EdgeInsets.symmetric(horizontal: 18.0),
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              indicatorColor: AppColors.white,
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
                    color: AppColors.white,
                  ),
                ),
                Tab(
                  child: Text(
                    "Offers",
                    style: TextStyle(
                      fontSize: 12,
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
            NestedOfferTabBar(
              "Offers",
            ),
            Channel()
          ],
        ),
      ),
    );
  }
}

class NestedOfferTabBar extends StatefulWidget {
  const NestedOfferTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedOfferTabBar> createState() => _NestedOfferTabBarState();
}

class _NestedOfferTabBarState extends State<NestedOfferTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _addOffersTabBarController = Get.find<TabBarController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: <Widget>[
          TabBar.secondary(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: 'For You'),
              Tab(text: 'Your listings'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                OfferForYou(),
                _addOffersTabBarController.isAddOfferButton.value
                    ? AddOffer()
                    : OfferListingsYour(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
