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
    rib = TextEditingController();
    balance = TextEditingController();
    super.onInit();
  }

  @override
  addacard(String userid, String usertoken) async {
    try {
      isloading = true;

      update();
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
