import 'package:bankpfe/screens/bnapay/allbills/donations.dart';
import 'package:bankpfe/screens/bnapay/allbills/electric_bills.dart';
import 'package:bankpfe/screens/bnapay/allbills/mobile_bills.dart';
import 'package:bankpfe/screens/bnapay/allbills/water_bills.dart';

import 'package:bankpfe/screens/bnapay/bills/money_transfer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/Model/card_model.dart';
import '../../screens/bnapay/allbills/internet_bills.dart';

abstract class SettingsController extends GetxController {
  fetchusercard();
}

class SettingsControllerImp extends SettingsController {
  SettingsControllerImp() {
    pagespay = [
      const ElectricBills(),
      const WaterBills(),
       MobileBills(mycard: usercards,username: username),
      const InternetBills(),
      MoneyTransfer(mycardList: usercards ,username: username),
      const Donations(),
    ];
  }
  List<String> categories = [
    "Electric bill",
    "Water bill",
    "Mobile bill",
    "Internet bill",
    "Send Money",
    "Donations"
  ];
  List<String> imagescateg = [
    "electricity",
    "water1",
    "mobile1",
    "internet1",
    "moneytransfer",
    "donate",
  ];
  List<Widget> pagespay = [];
  List<CardModel> usercards = [];
  String username = "Member";
  bool isloading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    _user = _auth.currentUser!;

    fetchusercard();
    super.onInit();
  }

  @override
  Future fetchusercard() async {
    try {
      isloading = true;
      update();
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(_user.uid).get();

      if (docSnapshot.exists) {
        QuerySnapshot notificationsSnapshot =
            await docSnapshot.reference.collection('cards').get();

        usercards.clear();
        for (var doc in notificationsSnapshot.docs) {
          usercards.add(CardModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
      isloading = false;

      update();
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again",
          backgroundColor: Colors.red);
    }
  }

  Future fetchUserData() async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(_user.uid).get();
      var userData = docSnapshot.data();

      if (docSnapshot.exists) {
        if (userData is Map<String, dynamic>) {
          username = userData['name'];
        }
      }
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please Check your internet connection",
          backgroundColor: Colors.red);
    }
  }
}
