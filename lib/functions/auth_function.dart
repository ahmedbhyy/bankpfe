import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

final LocalAuthentication auth = LocalAuthentication();
Future<bool> authenticate(String title) async {
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
