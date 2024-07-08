import 'package:bankpfe/data/Model/account_model.dart';
import 'package:bankpfe/data/Model/bill_model.dart';
import 'package:bankpfe/data/Model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminUserDetailsController extends GetxController {
  void updateColor(int index);
  fetchusercard(String userid);
  deleteaccount(String accountid, String userid);
}

class AdminUserDetailsControllerImp extends AdminUserDetailsController {
  List<String> categories = [];
  List<bool> isSelectedList = [];
  String categoriesname = "Information";
  bool isloading = false;

  AdminUserDetailsControllerImp() {
    categories = [
      "Information",
      "Accounts",
      "Bills",
      "Transactions",
    ];
    isSelectedList = List<bool>.filled(categories.length, false);
    isSelectedList[0] = true;
  }
  List<Icon> myicons = [
    const Icon(Icons.info),
    const Icon(Icons.add_card_sharp),
    const Icon(Icons.description_outlined),
    const Icon(Icons.arrow_outward_sharp),
  ];

  List<AccountModel> usercards = [];
  List<TransactionModel> usertransaction = [];
  List<BillModel> userbills = [];
  List<String> ribs = [];
  List<String> cardnumbers = [];
  List<String> relatedaccountsnumbers = [];

  @override
  void updateColor(index) {
    isSelectedList = List<bool>.filled(categories.length, false);
    isSelectedList[index] = !isSelectedList[index];
    categoriesname = categories[index];
    update();
  }

  @override
  Future fetchusercard(String userid) async {
    try {
      isloading = true;
      update();
      QuerySnapshot accountribsquery =
          await FirebaseFirestore.instance.collectionGroup('accounts').get();

      ribs = accountribsquery.docs
          .map((doc) => doc.get('accountcard.rib') as String)
          .toList();
          QuerySnapshot relatedaccountquery =
          await FirebaseFirestore.instance.collectionGroup('accounts').get();

      relatedaccountsnumbers = relatedaccountquery.docs
          .map((doc) => doc.get('accountcard.relatedaccount') as String)
          .toList();

           QuerySnapshot cardnumbersquery =
          await FirebaseFirestore.instance.collectionGroup('accounts').get();

      cardnumbers = cardnumbersquery.docs
          .map((doc) => doc.get('accountcard.cardnumber') as String)
          .toList();
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get();

      if (docSnapshot.exists) {
        QuerySnapshot cardsSnapshot =
            await docSnapshot.reference.collection('accounts').get();

        QuerySnapshot billsSnapshot =
            await docSnapshot.reference.collection('bills').get();
        QuerySnapshot transactionSnapshot =
            await docSnapshot.reference.collection('transactions').get();

        usercards.clear();
        for (var doc in cardsSnapshot.docs) {
          var account =
              AccountModel.fromJson(doc.data() as Map<String, dynamic>);
          account.id = doc.id;
          account.accountcard.id = doc.id;
          account.accountcard.relatedaccount = doc.id;
          usercards.add(account);
        }
        userbills.clear();
        for (var doc in billsSnapshot.docs) {
          userbills.add(BillModel.fromJson(doc.data() as Map<String, dynamic>));
        }
        usertransaction.clear();
        for (var doc in transactionSnapshot.docs) {
          usertransaction.add(
              TransactionModel.fromJson(doc.data() as Map<String, dynamic>));
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

  @override
  deleteaccount(String accountid, userid) async {
    try {
      Get.back();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('accounts')
          .doc(accountid)
          .delete();
      usercards.removeWhere((element) => element.id == accountid);
      Get.rawSnackbar(
          title: "Success",
          message: "You have deleted  this user",
          backgroundColor: Colors.green);
      update();
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again",
          backgroundColor: Colors.red);
    }
  }
}
