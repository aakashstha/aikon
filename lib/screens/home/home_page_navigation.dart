import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/firebase/auth_service.dart';
import 'package:aikon/screens/home/channel.dart';
import 'package:aikon/screens/home/offer_for_you.dart';
import 'package:aikon/screens/home/messages.dart';
import 'package:aikon/screens/home/settings.dart';
import 'package:aikon/screens/widgets/circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageNavigation extends StatefulWidget {
  const HomePageNavigation({Key? key}) : super(key: key);

  @override
  HomePageNavigationState createState() => HomePageNavigationState();
}

class HomePageNavigationState extends State<HomePageNavigation> {
  final AuthController _authController = Get.put(AuthController());
  int _selectedIndex = 0;

  final _pageOptions = <Widget>[
    OfferForYou(),
    Channel(),
    MessagesScreen(),
    SettingScreen()
  ];

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
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {},
      child: Scaffold(
        body: Obx(
          () => _authController.loadingTabBarNavigation.value
              ? Scaffold(
                  body: Center(
                  child: circularCenterScreenIndicator(),
                ))
              : Scaffold(
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
                              _authController.user.value.phoneNum!,
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
                          Get.toNamed("/AddOffer");
                        },
                        icon: const Icon(Icons.add, color: AppColors.white),
                      ),
                      PopupMenuButton(
                        iconColor: AppColors.white,
                        onSelected: (value) {
                          print(value);
                          int val = value as int;
                          setState(() {
                            if (val == 0) {
                              Get.toNamed("/OfferMyListing");
                            } else if (val == 1) {
                              Get.toNamed("/SettingScreen");
                            }
                          });
                        },
                        offset: Offset(0.0, AppBar().preferredSize.height),
                        itemBuilder: (ctx) => [
                          _buildPopupMenuItem('My Listings', Icons.search,
                              Icons.chevron_right, 0),
                          _buildPopupMenuItem('Settings', Icons.settings,
                              Icons.chevron_right, 1),
                        ],
                      )
                    ],
                  ),
                  body: _pageOptions[_selectedIndex],
                  bottomNavigationBar: Theme(
                    data: Theme.of(context).copyWith(
                        // sets the background color of the `BottomNavigationBar`
                        //canvasColor: Colors.green,
                        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                        textTheme: Theme.of(context).textTheme.copyWith(
                            bodySmall: const TextStyle(color: Colors.yellow))),
                    child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: AppColors.blueYonder,
                        selectedIconTheme:
                            const IconThemeData(color: AppColors.blueYonder),
                        unselectedIconTheme:
                            const IconThemeData(color: Colors.black),
                        selectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        currentIndex: _selectedIndex,
                        onTap: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Offers',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.tune),
                            label: 'Channel',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.message),
                            label: 'Messages',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label: 'Settings',
                          ),
                        ]),
                  ),
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
