import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';
import '../../functions/sendnotification.dart';

abstract class DonationsPayController extends GetxController {
  donateverify(
    String title,
    String description,
    double amount,
    String cardid,
    double currentbalance,
    String donationid,
    double currentamountdonation,
    int givers,
    double totalamountdonation,
  );
  updateindexz(int index);
}

class DonationsPayControllerImp extends DonationsPayController {
  TextEditingController? amount;
  TextEditingController? desc;
  GlobalKey<FormState> formStatedonation = GlobalKey<FormState>();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? userid;
  String? username;

  @override
  void onInit() async {
    amount = TextEditingController();
    desc = TextEditingController();
    userid = await secureStorage.read(key: "userid");
    username = await secureStorage.read(key: "username");
    update();
    super.onInit();
  }

  int z = 0;
  @override
  updateindexz(index) {
    z = index;
    update();
  }

  @override
  donateverify(title, description, amount, cardid, currentbalance, donationid,
      currentamountdonation, givers, totalamountdonation) async {
    if (await authenticate1("Verification") == true &&
        (currentamountdonation + amount) <= totalamountdonation &&
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
          .collection('Donations')
          .doc(donationid)
          .update({
        'currentamount': currentamountdonation + amount,
        'givers': givers + 1,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('transactions')
          .add({
        'amount': amount,
        'cardid': cardid,
        'category': "Donations transaction",
        'date': Timestamp.now(),
        'debit': "Debit",
        'internal': "Donation",
        'lottie': "images/lotties/lottie_minus.json",
        'title': "Donate to $title",
        'transcationtype': "Opération monétiques",
        'type': "Transfer",
      });
      sendNotification(
          "BNA DONATIONS", "You have donate to $title with $amount TND");
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "You have donate to $title with $amount TND");
    } else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Error, Please try again");
    }
  }
}
