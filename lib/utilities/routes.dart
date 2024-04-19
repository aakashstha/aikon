import 'package:aikon/screens/authentication/login.dart';
import 'package:aikon/screens/authentication/otp.dart';
import 'package:aikon/screens/authentication/select_channel.dart';
import 'package:aikon/screens/authentication/user_info.dart';
import 'package:aikon/screens/home/channel.dart';
import 'package:aikon/screens/home/offer_for_you.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/screens/others/add_offer.dart';
import 'package:aikon/screens/others/archive.dart';
import 'package:aikon/screens/others/favourite.dart';
import 'package:aikon/screens/others/offer_individual.dart';
import 'package:aikon/screens/others/offer_my_listings.dart';
import 'package:aikon/screens/others/settings.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/Login',
        page: () => Login(),
      ),
      GetPage(
        name: '/OTPScreen',
        page: () => OTPScreen(),
      ),
      GetPage(
        name: '/UserInfo',
        page: () => const UserInfo(),
      ),
      GetPage(
        name: '/SelectChannel',
        page: () => const SelectChannel(),
      ),
      GetPage(
        name: '/TabBarNavigation',
        page: () => const TabBarNavigation(),
      ),
      GetPage(
        name: '/AddOffer',
        page: () => AddOffer(),
      ),
      GetPage(
        name: '/OfferMyListing',
        page: () => const OfferMyListing(),
      ),
      GetPage(
        name: '/SettingScreen',
        page: () => const SettingScreen(),
      ),
      GetPage(
        name: '/OfferForYou',
        page: () => const OfferForYou(),
      ),
      GetPage(
        name: '/OfferIndividual',
        page: () => OfferIndividual(),
      ),
      GetPage(
        name: '/Channel',
        page: () => const Channel(),
      ),
      GetPage(
        name: '/FavouriteListing',
        page: () => const FavouriteListing(),
      ),
      GetPage(
        name: '/ArchiveListing',
        page: () => const ArchiveListing(),
      ),
    ];
