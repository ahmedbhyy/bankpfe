import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class DonationsDetailsController extends GetxController {
  openmaps(String url);
}

class DonationsDetailsControllerImp extends DonationsDetailsController {
  @override
  openmaps(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      Get.rawSnackbar(
        title: "Error",
        message: "Please try again later !",
        backgroundColor: Colors.red,
      );
    }
  }
}
