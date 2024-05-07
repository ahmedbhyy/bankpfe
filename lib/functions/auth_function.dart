import 'package:firebase_auth/firebase_auth.dart';
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

Future<void> _signInWithFirebaseAuthUid(
    String firebaseemail, String firebasepassword) async {
  try {
    await authfirebase.signInWithEmailAndPassword(
        email: firebaseemail, password: firebasepassword);
    Get.offAllNamed("/start");
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
