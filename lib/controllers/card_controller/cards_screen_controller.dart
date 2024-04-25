import 'package:bankpfe/functions/auth_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/Model/card_model.dart';
import '../../screens/cardscreens/qrscanner.dart';

abstract class CardsScreenController extends GetxController {
  addacard();
  fetchusercard();
}

class CardsScreenControllerImp extends CardsScreenController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<CardModel> usercards = [];

  bool isloading = false;
  @override
  addacard() async {
    if (await authenticate("Add a card") == true) {
      Get.to(() => const ScanQrCode());
    } else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }

  @override
  void onInit() {
    _user = _auth.currentUser!;

    fetchusercard();
    super.onInit();
  }

  @override
  Future fetchusercard() async {
    try {
      isloading = true;
      update();
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(_user.uid).get();

      if (docSnapshot.exists) {
        QuerySnapshot notificationsSnapshot =
            await docSnapshot.reference.collection('cards').get();

        usercards.clear();
        for (var doc in notificationsSnapshot.docs) {
          usercards.add(CardModel.fromJson(doc.data() as Map<String, dynamic>));
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
