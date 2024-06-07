

import 'package:bankpfe/firebase_options.dart';
import 'package:bankpfe/screens/homescreens/admin_page.dart';

import 'package:bankpfe/splash_screen.dart';
import 'package:bankpfe/start.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';

import 'screens/auth/signin.dart';
import 'screens/auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BnaApp());
}

class BnaApp extends StatefulWidget {
  const BnaApp({super.key});

  @override
  State<BnaApp> createState() => _BnaAppState();
}

class _BnaAppState extends State<BnaApp> {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BNA Bank",
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 3, 45, 107)),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashScreen(),
      // home: (FirebaseAuth.instance.currentUser != null &&
      //         FirebaseAuth.instance.currentUser!.emailVerified &&
      //         isadmin == "0")
      //     ? const StartScreen()
      //     : (FirebaseAuth.instance.currentUser != null &&
      //             FirebaseAuth.instance.currentUser!.emailVerified &&
      //             isadmin == "1")
      //         ? const AdminPage()
      //         : const ChooseLang(),
      getPages: [
        GetPage(name: "/signin", page: () => const SignIn()),
        GetPage(name: "/signup", page: () => const SignUp()),
        GetPage(name: "/start", page: () => const StartScreen()),
        GetPage(name: "/adminscreen", page: () => const AdminPage()),
      ],
    );
  }
}
