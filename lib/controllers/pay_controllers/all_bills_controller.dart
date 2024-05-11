import 'package:bankpfe/functions/sendnotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';

abstract class AllBillsController extends GetxController {
  paybill(String billid, String cardid, double amount, double currentbalance);
}

class AllBillsControllerImp extends AllBillsController {
  String? userid;
  @override
  paybill(billid, cardid, amount, currentbalance) async {
    if (await authenticate1("Verification") == true &&
        currentbalance > amount) {
      Get.back();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('bills')
          .doc(billid)
          .update({
        'ispayed': true,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('cards')
          .doc(cardid)
          .update({
        'balance': currentbalance - amount,
      });
      sendNotification("Pay Bills with BNA",
          "You have pay the bill with amount : $amount TND");
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "You have payed your bill");
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
}
