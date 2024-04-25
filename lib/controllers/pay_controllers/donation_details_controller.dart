import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../functions/auth_function.dart';

abstract class DonationsDetailsController extends GetxController {
  openmaps(String url);
  donateverify(String titledonate);
  changechekcboxcolor(int index);
}

class DonationsDetailsControllerImp extends DonationsDetailsController {
  TextEditingController? amount;

  GlobalKey<FormState> formStatedonation = GlobalKey<FormState>();
  DonationsDetailsControllerImp() {
    cardsdetails = [
      {
        "name1": "bnacard",
        "holdername": "Ahmed belhajyahia",
        "cardnumber": "1121090606",
        "background": "images/background1.jpg",
      },
      {
        "name1": "bnacard2",
        "holdername": "slim rkik",
        "cardnumber": "545066504",
        "background": "images/background2.jpg",
      }
    ];
    isSelectedList = List<bool>.filled(cardsdetails.length, false);
    isSelectedList[0] = true;
  }
  List cardsdetails = [];
  List<bool> isSelectedList = [];

  @override
  void onInit() {
    amount = TextEditingController();
    super.onInit();
  }

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

  @override
  donateverify(titledonate) async {
    if (await authenticate("Verification") == true) {
      Get.back();
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "You have donate to $titledonate");
    } else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }

  @override
  changechekcboxcolor(index) {
    isSelectedList = List<bool>.filled(cardsdetails.length, false);
    isSelectedList[index] = !isSelectedList[index];
    update();
  }
}
