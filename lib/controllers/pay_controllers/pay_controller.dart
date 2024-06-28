import 'package:bankpfe/data/Model/account_model.dart';
import 'package:bankpfe/data/Model/bill_model.dart';
import 'package:bankpfe/screens/bnapay/allbills/donations.dart';
import 'package:bankpfe/screens/bnapay/allbills/all_bills.dart';
import 'package:bankpfe/screens/bnapay/allbills/mobile_bills.dart';

import 'package:bankpfe/screens/bnapay/bills/money_transfer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../functions/auth_function.dart';

abstract class SettingsController extends GetxController {
  fetchusercard();
}

class SettingsControllerImp extends SettingsController {
  SettingsControllerImp() {
    pagespay = [
      AllBills(myaccounts: usercards, mybills: userbills),
      MobileBills(myaccounts: usercards),
      MoneyTransfer(
        mycardList: usercards,
      ),
      Donations(myaccounts: usercards),
    ];
  }
  List<String> categories = [
    "Pay Bills",
    "Mobile bill",
    "Send Money",
    "Donations"
  ];
  List<String> imagescateg = [
    "electricity",
    "mobile1",
    "moneytransfer",
    "donate",
  ];
  List<Widget> pagespay = [];
  List<AccountModel> usercards = [];
  List<BillModel> userbills = [];
  String? username = "Member";
  String? userid;
  bool isloading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    userid = await secureStorage.read(key: "userid");
    username = await secureStorage.read(key: "username");
    update();
    fetchusercard();
    super.onInit();
  }

  @override
  Future fetchusercard() async {
    try {
      isloading = true;
      update();
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(userid).get();

      if (docSnapshot.exists) {
        QuerySnapshot notificationsSnapshot =
            await docSnapshot.reference.collection('accounts').get();

        usercards.clear();
        for (var doc in notificationsSnapshot.docs) {
          var account =
              AccountModel.fromJson(doc.data() as Map<String, dynamic>);
          account.id = doc.id;
          account.accountcard.id = doc.id;
          account.accountcard.relatedaccount = doc.id;
          usercards.add(account);
        }

        QuerySnapshot billsSnapshot =
            await docSnapshot.reference.collection('bills').get();

        userbills.clear();
        for (var doc in billsSnapshot.docs) {
          var billData = doc.data() as Map<String, dynamic>;
          billData['id'] = doc.id;
          userbills.add(BillModel.fromJson(billData));
        }
      }
      isloading = false;

      update();
    } catch (e) {
      isloading = false;

      update();
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again",
          backgroundColor: Colors.red);
    }
  }
}
