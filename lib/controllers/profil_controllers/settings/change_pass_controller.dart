import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ChangePassController extends GetxController {
  sendemail();
}

class ChangePassControllerImp extends ChangePassController {
  late User _user;
  bool isloading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formStatechangepassword = GlobalKey<FormState>();

  @override
  void onInit() {
    _user = _auth.currentUser!;
    super.onInit();
  }

  @override
  sendemail() async {
    try {
      isloading = true;
      update();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _user.email!);
      isloading = false;
      update();
      return Get.rawSnackbar(
          title: "Change Password",
          message:
              "An email was send successfully to you please check your email box and Change your password !",
          backgroundColor: Colors.green);
    } catch (e) {
      isloading = false;
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again",
          backgroundColor: Colors.red);
    }
  }
}
