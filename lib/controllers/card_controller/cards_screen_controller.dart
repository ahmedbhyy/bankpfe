import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/Model/card_model.dart';

abstract class CardsScreenController extends GetxController {
  fetchusercard();
}

class CardsScreenControllerImp extends CardsScreenController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  String username = "Member";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<CardModel> usercards = [];

  bool isloading = false;

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

      var userData = docSnapshot.data();

      if (docSnapshot.exists) {
        if (userData is Map<String, dynamic>) {
          username = userData['name'] ?? "Member";
          update();
        }
        QuerySnapshot notificationsSnapshot =
            await docSnapshot.reference.collection('cards').get();

        usercards.clear();
        for (var doc in notificationsSnapshot.docs) {
          var usercards1 =
              CardModel.fromJson(doc.data() as Map<String, dynamic>);
          usercards1.id = doc.id;
          usercards.add(usercards1);
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
