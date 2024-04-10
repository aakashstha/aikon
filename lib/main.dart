import 'package:aikon/constants/colors.dart';
import 'package:aikon/constants/constants.dart';
import 'package:aikon/firebase_options.dart';
import 'package:aikon/screens/authentication/login.dart';
import 'package:aikon/screens/authentication/otp.dart';
import 'package:aikon/screens/authentication/select_channel.dart';
import 'package:aikon/screens/authentication/user_info.dart';
import 'package:aikon/screens/home/tabbar_navigation.dart';
import 'package:aikon/utilities/routes.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  StorageGetX.initializeStorageGetX();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueYonder),
        useMaterial3: true,
      ),
      home: TabBarNavigation(),
      // home: SelectChannel(),
      // home: Login(),

      // getPages: appRoutes(),
    );
  }
}
