import 'package:aikon/screens/authentication/login.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/screens/others/offer_my_listings.dart';
import 'package:get/get.dart';

appRoutes() => [
      // GetPage(
      //   name: '/RegisterProcess',
      //   page: () => const RegisterProcess(),
      // ),
      GetPage(
        name: '/Login',
        page: () => Login(),
      ),
      GetPage(
        name: '/TabBarNavigation',
        page: () => const TabBarNavigation(),
      ),
      GetPage(
        name: '/OfferMyListing',
        page: () => const OfferMyListing(),
      ),
      // GetPage(
      //   name: '/ForgetPassword',
      //   page: () => const ForgetPassword(),
      // ),
      // GetPage(
      //   name: '/RoleIndividual',
      //   page: () => const RoleIndividual(),
      // ),
      // GetPage(
      //   name: '/NewsIndividual',
      //   page: () => const NewsIndividual(),
      // ),
      // GetPage(
      //   name: '/JobIndividual',
      //   page: () => const JobIndividual(),
      // ),
      // GetPage(
      //   name: '/Chat',
      //   page: () => const Chat(),
      // ),
      // GetPage(
      //   name: '/ResetPassword',
      //   page: () => const ResetPassword(),
      // ),
    ];
