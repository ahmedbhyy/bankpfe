import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

final LocalAuthentication auth = LocalAuthentication();
final FirebaseAuth authfirebase = FirebaseAuth.instance;

FlutterSecureStorage secureStorage = const FlutterSecureStorage();

Future<void> authenticate(String title) async {
  try {
    bool authenticated = await auth.authenticate(
      localizedReason: "Use your Biometric to $title",
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),
    );
    if (authenticated) {
      String? firebaseemail = await secureStorage.read(key: "email");
      String? firebasepassword = await secureStorage.read(key: "password");
      if (firebaseemail != null && firebasepassword != null) {
        await _signInWithFirebaseAuthUid(firebaseemail, firebasepassword);
      } else {
        Get.rawSnackbar(
            title: "Error",
            message: "Please sign in for the first time and then continue");
      }
    } else {
      Get.rawSnackbar(title: "Error", message: "Please try again.");
    }
  } on PlatformException catch (e) {
    Get.rawSnackbar(title: "Error", message: e.message);
  }
}

Future _signInWithFirebaseAuthUid(
    String firebaseemail, String firebasepassword) async {
  try {
    final credential = await authfirebase.signInWithEmailAndPassword(
        email: firebaseemail, password: firebasepassword);
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user!.uid)
        .get();
    var userData = docSnapshot.data();
    if (credential.user!.emailVerified) {
      if (docSnapshot.exists) {
        if (userData is Map<String, dynamic>) {
          if (userData['isadmin'] == true) {
            Get.offAllNamed("/adminscreen");
            await secureStorage.write(
              key: "isadmin",
              value: "1",
            );
          } else {
            Get.offAllNamed("/start");
            await secureStorage.write(
              key: "isadmin",
              value: "0",
            );
          }
        }
      } else {
        Get.offAllNamed("/start");
        await secureStorage.write(
          key: "isadmin",
          value: "0",
        );
      }
    } else {
      return Get.rawSnackbar(
          title: "Verify Your Account",
          message: "An email was send to you. Please verify your Account",
          backgroundColor: Colors.red);
    }
  } catch (e) {
    Get.rawSnackbar(title: "Error", message: "Please try again.");
  }
}

Future<bool> authenticate1(String title) async {
  try {
    bool authenticated = await auth.authenticate(
      localizedReason: "Use your Biometric to $title",
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),
    );
    return authenticated;
  } on PlatformException catch (e) {
    Get.rawSnackbar(title: "Error", message: e.message);
    return false;
  }
}
