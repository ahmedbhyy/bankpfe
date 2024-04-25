import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HelpController extends GetxController {
  sendreport();
}

class HelpControllerImp extends HelpController {
  TextEditingController helpcontroller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;
  bool isloading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formStatereport = GlobalKey<FormState>();

  @override
  void onInit() {
    _user = _auth.currentUser!;
    super.onInit();
  }

  @override
  void dispose() {
    helpcontroller.dispose();
    super.dispose();
  }

  @override
  Future sendreport() async {
    try {
      isloading = true;
      update();
      String report = helpcontroller.text;

      await _firestore.collection('reports').add({
        'report': report,
        'useremail': _user.email,
        'userid': _user.uid,
      });
      isloading = false;
      Get.back();
      Get.rawSnackbar(
          title: "Success",
          message: "Your report was send successfully",
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
