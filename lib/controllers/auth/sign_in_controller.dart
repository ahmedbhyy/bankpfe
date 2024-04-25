import 'package:bankpfe/screens/auth/signup.dart';
import 'package:bankpfe/slides/slide_right.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

abstract class SignInController extends GetxController {
  hidepaasword();
  gotosignup(BuildContext context);
  signin(String email, String password);
  forgetpassword(String email);
}

class SignInControllerImp extends SignInController {
  bool ispasswordhidden = true;
  bool isloading1 = false;
  bool isloading2 = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formStateSignIn = GlobalKey<FormState>();

  final LocalAuthentication auth = LocalAuthentication();
  bool supportstate = false;

  @override
  hidepaasword() {
    ispasswordhidden = !ispasswordhidden;
    update();
  }

  @override
  gotosignup(BuildContext context) {
    Navigator.of(context).pushReplacement(
      SlideRight(
        page: const SignUp(),
      ),
    );
  }

  @override
  void onInit() {
    auth.isDeviceSupported().then(
          (bool issupported) => supportstate = issupported,
        );
    super.onInit();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  signin(String email, String password) async {
    try {
      isloading1 = true;
      update();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isloading1 = false;
      update();
      if (credential.user!.emailVerified) {
        Get.offAllNamed("/start");
      } else {
        return Get.rawSnackbar(
            title: "Verify Your Account",
            message: "An email was send to you. Please verify your Account",
            backgroundColor: Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      isloading1 = false;
      if (e.code == 'user-not-found') {
        return Get.rawSnackbar(
            title: "user-not-found",
            message: "No user found for that email. Please Sign up",
            backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        return Get.rawSnackbar(
            title: "Wrong password",
            message: "Wrong password provided for that user.",
            backgroundColor: Colors.red);
      } else {
        return Get.rawSnackbar(
            title: "Error",
            message: "Please try again",
            backgroundColor: Colors.red);
      }
    }
  }

  @override
  forgetpassword(String email) async {
    try {
      isloading2 = true;
      update();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      isloading2 = false;
      update();
      return Get.rawSnackbar(
          title: "Reset Password",
          message: "An email was send to you. Please Reset your password !",
          backgroundColor: Colors.green);
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Email not found. Please try again",
          backgroundColor: Colors.red);
    }
  }
}
