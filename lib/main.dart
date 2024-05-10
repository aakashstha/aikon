import 'package:aikon/cometchat/cometchat_service.dart';
import 'package:aikon/constants/colors.dart';
import 'package:aikon/constants/constants.dart';
import 'package:aikon/controller/cometchat_controller.dart';
import 'package:aikon/firebase_options.dart';
import 'package:aikon/screens/authentication/login.dart';
import 'package:aikon/screens/home/home_page_navigation.dart';
import 'package:aikon/utilities/routes.dart';
import 'package:aikon/utilities/storage_getx.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  StorageGetX.initializeStorageGetX();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await CometChatService.initialise();
    // await CometChatService.logout();
    await CometChatService.login();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueYonder),
        useMaterial3: true,
      ),
      home: HomePageNavigation(),
      // home: UserInfo(),
      // home: SelectChannel(),
      // home: Login(),

      getPages: appRoutes(),
    );
  }
}
