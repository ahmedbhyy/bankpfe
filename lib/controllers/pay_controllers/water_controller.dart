import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';

abstract class WaterController extends GetxController {
  paywater();
}

class WaterControllerImp extends WaterController {
  List<String> userinfo = [
    "Name",
    "Card",
    "Address",
    "Phone number",
    "code",
    "Date",
    "Water fee",
    "Tax",
    "Total",
  ];

  @override
  paywater() async {
    if (await authenticate("Verification") == true) {
      Get.back();
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success", message: "You have payed your water bill");
    } else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }
}
