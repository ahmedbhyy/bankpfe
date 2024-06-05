import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';
import '../../functions/sendnotification.dart';

abstract class PayMobileController extends GetxController {
  updateindex(int index);
  updateimage(String text);
  updateindexz(int index);
  paymobilebill(
    String cardid,
    double amount,
    double currentbalance,
  );
}

class PayMobileControllerImp extends PayMobileController {
  TextEditingController phonenumber = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  int i = 0;
  int j = 0;
  int z = 0;

  String? userid;

  List<String> amounts = [
    "10",
    "20",
    "25",
    "30",
    "35",
    "40",
  ];
  List<Widget> mywidgets = [
    const Text("write your phone number"),
    Image.asset(
      "images/orange.png",
      height: 30.0,
    ),
    Image.asset(
      "images/tt.png",
      height: 30.0,
    ),
    Image.asset(
      "images/ooredoo.png",
      height: 30.0,
    ),
    const Text("verify your phone number"),
  ];
  @override
  updateindexz(index) {
    z = index;
    update();
  }

  @override
  updateindex(index) {
    i = index;
    update();
  }

  @override
  updateimage(text) {
    if (text.isEmpty || text.length != 8 || !text.isNumericOnly) {
      j = 0;
      update();
    } else if (text[0] == '5') {
      j = 1;
      update();
    } else if (text[0] == '9') {
      j = 2;
      update();
    } else if (text[0] == '2') {
      j = 3;
      update();
    } else {
      j = 4;
      update();
    }
  }

  @override
  paymobilebill(cardid, amount, currentbalance) async {
    if (await authenticate1("Verification") == true &&
        currentbalance > amount) {
      Get.back();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('cards')
          .doc(cardid)
          .update({
        'balance': currentbalance - amount,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('transactions')
          .add({
        'amount': amount,
        'cardid': cardid,
        'category': "Billed transaction",
        'date': Timestamp.now(),
        'debit': "Debit",
        'internal': "7879456489",
        'lottie': "images/lotties/lottie_minus.json",
        'title': "Send to (${phonenumber.text})",
        'transcationtype': "Opération monétiques",
        'type': "Transfer",
      });
      sendNotification("Mobile Payment with BNA",
          "You have send $amount to ${phonenumber.text} TND");
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "You have send $amount to ${phonenumber.text} TND");
    } else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }

  @override
  void onInit() async {
    userid = await secureStorage.read(key: "userid");
    super.onInit();
  }

  @override
  void dispose() async {
    phonenumber.dispose();

    super.dispose();
  }
}
