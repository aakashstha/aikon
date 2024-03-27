import 'package:aikon/controller/firebase_authentication.dart';
import 'package:aikon/controller/firebase_crud_controller.dart';
import 'package:aikon/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final FirebaseController _firebaseController = Get.put(FirebaseController());
  final FirebaseAuthenticationController _firebaseAuth =
      Get.put(FirebaseAuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: const Text(
              "Send OTP",
              style: TextStyle(fontSize: 30),
            ),
            onTap: () {
              _firebaseAuth.sendOTP();
            },
          ),
          const SizedBox(height: 50),
          InkWell(
            child: const Text(
              "verify OTP",
              style: TextStyle(fontSize: 30),
            ),
            onTap: () {
              _firebaseAuth.verifyOTP();
            },
          ),
        ],
      ),
    );
  }
}
