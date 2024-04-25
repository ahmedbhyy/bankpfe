import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';

abstract class ElectricController extends GetxController {
  payelectric();
}

class ElectricControllerImp extends ElectricController {
  List<String> userinfo = [
    "Name",
    "Card",
    "Address",
    "Phone number",
    "code",
    "Date",
    "Electric fee",
    "Tax",
    "Total",
  ];

  @override
  payelectric() async {
    if (await authenticate("Verification") == true) {
      Get.back();
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
        title: "Success", message: "You have payed your electric bill");
    }else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }
}
