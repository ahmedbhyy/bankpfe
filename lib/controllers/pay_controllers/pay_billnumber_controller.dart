import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';

import '../../functions/auth_function.dart';
import '../../functions/sendnotification.dart';

enum SampleItem { itemone, itemTwo, itemThree, itemFour, itemFive }

abstract class PayBillnumberController extends GetxController {
  updateindexz(int index);
  paybill(String cardid, double amount, double currentbalance, String billtype,
      String billnumber);
}

class PayBillnumberControllerImp extends PayBillnumberController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  TextEditingController? billnumber;
  TextEditingController? billamount;
  TextEditingController? billtype;

  SampleItem? selectedItem;

  String? username;

  List<SampleItem> sampleitemlisty = [
    SampleItem.itemone,
    SampleItem.itemTwo,
    SampleItem.itemThree,
  ];
  List<String> names = ["Water bill", "Electric bill", "Internet bill"];
  int z = 0;
  @override
  updateindexz(index) {
    z = index;
    update();
  }

  @override
  void onInit() async {
    billamount = TextEditingController();
    billnumber = TextEditingController();
    billtype = TextEditingController();
    userid = await secureStorage.read(key: "userid");
    username = await secureStorage.read(key: "username");
    update();
    super.onInit();
  }

  String? userid;
  @override
  paybill(cardid, amount, currentbalance, billtype, billnumber) async {
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
        'internal': billnumber,
        'lottie': "images/lotties/lottie_minus.json",
        'title': "Pay $billtype",
        'transcationtype': "Opération monétiques",
        'type': "Transfer",
      });
      sendNotification("Pay Bills with BNA",
          "You have pay $billtype with amount : $amount TND");
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
}
