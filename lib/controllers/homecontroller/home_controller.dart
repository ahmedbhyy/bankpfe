import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/Model/card_model.dart';

abstract class HomeController extends GetxController {
  void updateColor(int index);
  void fetchProfileImage();
  fetchusercard();
}

class HomeControllerImp extends HomeController {
  String imagefile = "https://cdn-icons-png.freepik.com/512/3001/3001764.png";
  String username = "Member";
  bool isloading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  HomeControllerImp() {
    categories = [
      "All",
      "Added",
      "Expand",
      "Send",
      "Cancel",
    ];
    isSelectedList = List<bool>.filled(categories.length, false);
    isSelectedList[0] = true;
  }

  List<String> categories = [];

  List<bool> isSelectedList = [];

  List<CardModel> usercards = [];

  List transactions = [
    {
      "title": "Transfer to shiki",
      "lottie": "images/lotties/lottie_minus.json",
      "date": "Apr 12,2014",
      "type": "Transfer",
      "amount": 320.052,
      "myicon": const Icon(
        Icons.remove_circle_outline,
        size: 15.0,
        color: Colors.red,
      ),
    },
    {
      "title": "DAB/AGENCE EL MOUROUJ",
      "lottie": "images/lotties/lottie_minus.json",
      "date": "Apr 13,2014",
      "type": "Retrait",
      "amount": 200.052,
      "myicon": const Icon(
        Icons.remove_circle_outline,
        size: 15.0,
        color: Colors.red,
      ),
    },
    {
      "title": "Virement tunisie autre banque",
      "lottie": "images/lotties/lottie_added.json",
      "date": "Apr 14,2014",
      "type": "Added",
      "amount": 120.052,
      "myicon": const Icon(
        Icons.add_circle_outline,
        size: 15.0,
        color: Colors.green,
      ),
    },
    {
      "title": "Retenue a la source",
      "lottie": "images/lotties/lottie_minus.json",
      "date": "Apr 10,2014",
      "type": "Retrait",
      "amount": 520.052,
      "myicon": const Icon(
        Icons.remove_circle_outline,
        size: 15.0,
        color: Colors.red,
      ),
    },
  ];

  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  void updateColor(index) {
    isSelectedList = List<bool>.filled(categories.length, false);
    isSelectedList[index] = !isSelectedList[index];
    update();
  }

  @override
  void onInit() {
    _user = _auth.currentUser!;
    fetchUserData();
    fetchProfileImage();
    fetchusercard();
    super.onInit();
  }

  @override
  fetchProfileImage() {
    final store = FirebaseStorage.instance.ref();
    final newprofilpic = FirebaseAuth.instance.currentUser!.uid;
    final pdpref = store.child("profil/$newprofilpic.jpg");
    try {
      pdpref.getDownloadURL().then((value) {
        imagefile = value;
        update();
      }, onError: (val) {});
    } catch (e) {
      Get.rawSnackbar(title: "Error", message: "please try again");
    }
  }

  Future fetchUserData() async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(_user.uid).get();
      var userData = docSnapshot.data();

      if (docSnapshot.exists) {
        if (userData is Map<String, dynamic>) {
          username = userData['name'] ?? "Member";
        }
      }
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please Check your internet connection",
          backgroundColor: Colors.red);
    }
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
