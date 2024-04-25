



import 'package:bankpfe/screens/profil_screen/edit_profil.dart';
import 'package:bankpfe/screens/profil_screen/exchange.dart';
import 'package:bankpfe/screens/profil_screen/find_us.dart';
import 'package:bankpfe/screens/profil_screen/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


abstract class ProfilController extends GetxController {

  logout();
}

class ProfilControllerImp extends ProfilController {

  String imageFile = "https://cdn-icons-png.freepik.com/512/3001/3001764.png";
  ProfilControllerImp() {
    categoriespages = [
      const EditProfil(),
      const SettingsProfil(),
      const Exchange(),
      const FindUs()
    ];
  }
  List<String> categoriesprofil = [
    "Edit Profil",
    "Settings",
    "Exchange",
    "Find Us"
  ];
  List<String> categoriesprofilimages = [
    "editprofil",
    "settings",
    "exchange",
    "findus"
  ];
  List<String> categoriesprofildescription = [
    "edit your profil",
    "chnage settings",
    "Exchange with us",
    "Find Us or contact us"
  ];
  List<Widget> categoriespages = [];

 

  @override
  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed("/signin");
    } catch (e) {
      return;
    }
  }

  

  
}
