import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';
import '../../functions/sendnotification.dart';

enum SampleItem { itemone.new(), itemTwo, itemThree }

abstract class MoneyTransferController extends GetxController {
  updateindex(int index);
  updateColor(int index);
  verifyuser(double amount,String to ,String cardid,double balance);
}

class MoneyTransferControllerImp extends MoneyTransferController {
  MoneyTransferControllerImp() {
    choices = [
      {
        "myicon": const Icon(
          Icons.person_pin_circle_outlined,
          color: Colors.white,
        ),
        "mytitle": "Transfer to the same bank"
      },
      {
        "myicon": const Icon(
          Icons.account_balance_rounded,
          color: Colors.white,
        ),
        "mytitle": "Transfer to another bank"
      },
      {
        "myicon": const Icon(
          Icons.wifi_tethering_outlined,
          color: Colors.white,
        ),
        "mytitle": "international money transfer"
      },
    ];
    isSelectedList = List<bool>.filled(choices.length, false);
    isSelectedList[0] = true;
  }

   String? userid;
  TextEditingController cardnumber = TextEditingController();

  TextEditingController amount = TextEditingController();

  TextEditingController content = TextEditingController();

  List choices = [];

  SampleItem? selectedItem;
  List<bool> isSelectedList = [];

  int i = 0;

  GlobalKey<FormState> formStatemoneytransfer = GlobalKey<FormState>();

  @override
  updateindex(index) {
    i = index;
    update();
  }

  List cardsdetails = [
    {
      "name1": "bnacard",
      "amount": 350.000,
      "holdername": "Ahmed belhajyahia",
      "cardnumber": "1121090606",
      "background": "images/background1.jpg",
    },
    {
      "name1": "bnacard2",
      "amount": 465.252,
      "holdername": "slim rkik",
      "cardnumber": "545066504",
      "background": "images/background2.jpg",
    }
  ];

  @override
  void updateColor(index) {
    isSelectedList = List<bool>.filled(choices.length, false);
    isSelectedList[index] = !isSelectedList[index];
    update();
  }

  @override
  verifyuser(amount,to,cardid,balance) async {
    if (await authenticate1("Verification") == true) {
      Get.back();
      sendNotification(
          "BNA Send Money", "You have send $amount TND to $to");
          await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('cards')
          .doc(cardid)
          .update({
        'balance': balance - amount,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('transactions')
          .add({
        'amount': amount,
        'category':"Transaction",
        'date': Timestamp.now(),
        'debit': "Debit",
        'internal': "FT245056540845646",
        'lottie': "images/lotties/lottie_minus.json",
        'title': "Send Money ($amount TND)",
        'transcationtype': "Opération monétiques",
        'type': "Transfer",
      });
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "Transfer successfuly");
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
