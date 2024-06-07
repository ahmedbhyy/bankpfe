import 'package:bankpfe/data/Model/bill_model.dart';
import 'package:bankpfe/data/Model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/Model/card_model.dart';

abstract class AdminUserDetailsController extends GetxController {
  void updateColor(int index);
  fetchusercard(String userid);
}

class AdminUserDetailsControllerImp extends AdminUserDetailsController {
  List<String> categories = [];
  List<bool> isSelectedList = [];
  String categoriesname = "Information";
  bool isloading = false;

  AdminUserDetailsControllerImp() {
    categories = [
      "Information",
      "Cards",
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

  List<CardModel> usercards = [];
  List<TransactionModel> usertransaction = [];
  List<BillModel> userbills = [];

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
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get();

      if (docSnapshot.exists) {
        QuerySnapshot cardsSnapshot =
            await docSnapshot.reference.collection('cards').get();

        QuerySnapshot billsSnapshot =
            await docSnapshot.reference.collection('bills').get();
        QuerySnapshot transactionSnapshot =
            await docSnapshot.reference.collection('transactions').get();

        usercards.clear();
        for (var doc in cardsSnapshot.docs) {
          usercards.add(CardModel.fromJson(doc.data() as Map<String, dynamic>));
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
}
