import 'package:bankpfe/screens/auth/signin.dart';

import 'package:bankpfe/slides/slide_right.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  validatePassword(String value);
  hidepaasword();
  hiderepaasword();
  signup(String email, String password, BuildContext context);
  gotosignIn(BuildContext context);
}

class SignUpControllerImp extends SignUpController {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController repasswordcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isPasswordHidden = true;
  bool isrePasswordHidden = true;
  bool isloading = false;
  GlobalKey<FormState> formStatesingup = GlobalKey<FormState>();

  @override
  hidepaasword() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  @override
  gotosignIn(BuildContext context) {
    Navigator.of(context).pushReplacement(
      SlideRight(
        page: const SignIn(),
      ),
    );
  }

  @override
  void dispose() {
    passwordcontroller.dispose();
    emailcontroller.dispose();
    repasswordcontroller.dispose();
    usernamecontroller.dispose();
    super.dispose();
  }

  @override
  validatePassword(value) {
    if (value != passwordcontroller.text) {
     return "Password do not match";
    }
   
  }

  @override
  hiderepaasword() {
    isrePasswordHidden = !isrePasswordHidden;
    update();
  }

  @override
  signup(email, password, context) async {
    try {
      isloading = true;
      update();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      isloading = false;
      update();
      // ignore: use_build_context_synchronously
      gotosignIn(context);
      Get.rawSnackbar(
          title: "Verify Your Account",
          message:
              "An email was send to you. Please verify your Account and sign in",
          backgroundColor: Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Get.rawSnackbar(
            title: "ERROR",
            message: "The password provided is too weak.",
            backgroundColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        return Get.rawSnackbar(
            title: "ERROR",
            message: "The account already exists for that email.",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      return Get.rawSnackbar(
          title: "ERROR",
          message: "Please try again later !",
          backgroundColor: Colors.red);
    }
  }
}
