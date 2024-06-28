import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bankpfe/screens/homescreens/admin_page.dart';
import 'package:bankpfe/screens/splashscreens/onboarding.dart';
import 'package:bankpfe/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterSecureStorage mystorage = const FlutterSecureStorage();
  String? isadmin;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      final isadmin = await mystorage.read(key: "isadmin");
      (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified &&
              isadmin == "0")
          ? Get.offAll(() => const StartScreen())
          : (FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified &&
                  isadmin == "1")
              ? Get.offAll(() => const AdminPage())
              : Get.offAll(() => const OnBoarding());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeOut(
              delay: const Duration(seconds: 2),
              child: Image.asset(
                "images/bna.png",
                height: 120.0,
              ),
            ),
            Lottie.asset("images/lotties/lottie_loading.json", height: 40.0),
          ],
        ),
      ),
    );
  }
}
