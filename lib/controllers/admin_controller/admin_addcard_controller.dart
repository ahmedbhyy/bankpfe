import 'dart:math';

import 'package:bankpfe/functions/sendnotification_token.dart';
import 'package:bankpfe/screens/homescreens/admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SampleItem { itemone, itemTwo, itemThree }

abstract class AdminAddcardController extends GetxController {
  addacard(String userid, String usertoken);
}

class AdminAddcardControllerImp extends AdminAddcardController {
  TextEditingController? accountnumber;
  TextEditingController? cardtype;
  TextEditingController? cin;
  bool isloading = false;
  TextEditingController? cardnumber;
  TextEditingController? rib;
  TextEditingController? balance;
  GlobalKey<FormState> formStatecard = GlobalKey<FormState>();
  SampleItem? selectedItem;

  List<SampleItem> sampleitemlisty = [
    SampleItem.itemone,
    SampleItem.itemTwo,
  ];

  List<String> names = ["EPARGNE", "INFINITE"];
  @override
  void onInit() {
    cardtype = TextEditingController();
    accountnumber = TextEditingController();
    cardnumber = TextEditingController();
    cin = TextEditingController();
    rib = TextEditingController();
    balance = TextEditingController();
    super.onInit();
  }

  String generateRIB() {
    Random random = Random();

    String part1 = random.nextInt(100).toString().padLeft(2, '0');

    String part2 = random.nextInt(1000).toString().padLeft(3, '0');

    String part3 = '';
    for (int i = 0; i < 13; i++) {
      part3 += random.nextInt(10).toString();
    }

    String part4 = random.nextInt(100).toString().padLeft(2, '0');

    return '$part1-$part2-$part3-$part4';
  }

  String generateUniqueRIB(List<String> existingRIBs) {
    String newRIB;

    do {
      newRIB = generateRIB();
    } while (existingRIBs.contains(newRIB));

    return newRIB;
  }

  String generateCardNumber() {
    Random random = Random();

    String part1 = random.nextInt(10000).toString().padLeft(4, '0');
    String part2 = random.nextInt(10000).toString().padLeft(4, '0');
    String part3 = random.nextInt(10000).toString().padLeft(4, '0');
    String part4 = random.nextInt(10000).toString().padLeft(4, '0');

    return '$part1 $part2 $part3 $part4';
  }

  String generateUniqueCardNumber(List<String> existingCardNumbers) {
    String newCardNumber;

    do {
      newCardNumber = generateCardNumber();
    } while (existingCardNumbers.contains(newCardNumber));

    return newCardNumber;
  }

  String generateRelatedAccount() {
    Random random = Random();

    String part1 = "M3";
    String part2 = random.nextInt(100).toString().padLeft(2, '0');
    String part3 = random.nextInt(100000).toString().padLeft(5, '0');
    String part4 = random.nextInt(10).toString();

    return '$part1-$part2-$part3-$part4';
  }

  String generateUniqueRelatedAccount(List<String> existingRelatedAccounts) {
    String newRelatedAccount;

    do {
      newRelatedAccount = generateRelatedAccount();
    } while (existingRelatedAccounts.contains(newRelatedAccount));

    return newRelatedAccount;
  }

  @override
  addacard(String userid, String usertoken) async {
    try {
      isloading = true;

      update();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .set({'cin': cin!.text}, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('accounts')
          .add({
        'accountnumber': accountnumber!.text,
        'crationdate': Timestamp.now(),
        'accountcard': {
          'background': cardtype!.text == "EPARGNE"
              ? "images/background2.jpg"
              : "images/background1.jpg",
          'balance': double.parse(balance!.text),
          'cardnumber': cardnumber!.text,
          'cardtype': cardtype!.text,
          'name': cardtype!.text == "EPARGNE" ? "bnacard2" : "bnacard",
          'relatedaccount': accountnumber!.text,
          'rib': rib!.text,
        }
      });
      isloading = false;

      update();
      Get.offAll(const AdminPage());
      sendNotificationToken(
          "New Card", "your card is now available check it", usertoken);
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "We have added a card to $userid");
    } catch (e) {
      isloading = false;
      update();
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Please try again.");
    }
  }
}
