import 'package:bankpfe/screens/cardscreens/card_screen.dart';
import 'package:bankpfe/screens/homescreens/home_screen.dart';
import 'package:bankpfe/screens/profil_screen/profil_screen.dart';
import 'package:bankpfe/screens/bnapay/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../screens/homescreens/notifications.dart';

abstract class StartController extends GetxController {
  void generatewindow(int i);
}

class StartControllerImp extends StartController {
  int selectedIndex = 0;
  String? userid;
  
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  late User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Widget> listpage = [
    const HomeScreen(),
    const CardScreen(),
    const SettingsScreen(),
    const ProfilScreen(),
  ];

  @override
  void onInit()async {
    _user = _auth.currentUser!;
    userid = _user.uid;
     await secureStorage.write(
        key: "userid",
        value: userid,
      );
    FirebaseMessaging.instance.subscribeToTopic('BNA');
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.to(const Notifications());
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Get.snackbar(
            "${message.notification!.title}", "${message.notification!.body}");
      }
    });
    gettoken();
    super.onInit();
  }

  gettoken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance.collection('users').doc(_user.uid).set(
      {
        'token': token,
      },
      SetOptions(merge: true),
    );
     await secureStorage.write(
      key: "usertoken",
      value: token,
    );
  }

  @override
  generatewindow(i) {
    selectedIndex = i;
    update();
  }
}
