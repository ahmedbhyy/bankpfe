import 'package:bankpfe/functions/sendnotification_token.dart';
import 'package:bankpfe/screens/homescreens/admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminAddcardController extends GetxController {
  addacard(String userid, String usertoken);
}

class AdminAddcardControllerImp extends AdminAddcardController {
  TextEditingController? cardnumber;
  TextEditingController? cardtype;
  TextEditingController? relatedaccount;
  TextEditingController? rib;
  TextEditingController? balance;
  GlobalKey<FormState> formStatecard = GlobalKey<FormState>();

  @override
  void onInit() {
    cardtype = TextEditingController();
    cardnumber = TextEditingController();
    relatedaccount = TextEditingController();
    rib = TextEditingController();
    balance = TextEditingController();
    super.onInit();
  }

  @override
  addacard(String userid, String usertoken) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('cards')
          .add({
        'background': "images/background2.jpg",
        'balance': double.parse(balance!.text),
        'cardnumber': cardnumber!.text,
        'cardtype': cardtype!.text,
        'name': "bnacard2",
        'relatedaccount': relatedaccount!.text,
        'rib': rib!.text,
      });
      Get.offAll(const AdminPage());
      sendNotificationToken(
          "New Card", "your card is now available check it ", usertoken);
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "We have added a card to $userid");
    } catch (e) {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Please try again.");
    }
  }
}
