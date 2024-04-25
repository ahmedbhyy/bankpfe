import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';

abstract class InternetController extends GetxController {
  payinternetbill();
}

class InternetControllerImp extends InternetController {
  List<String> userinfo = [
    "Company",
    "Card",
    "Phone number",
    "code",
    "Date",
    "Amount",
  ];

  @override
  payinternetbill() async {
    if (await authenticate("Verification") == true) {
      Get.back();
      return Get.rawSnackbar(
        backgroundColor:const Color(0xff00aa86) ,
          title: "Success", message: "You have payed your internet bill");
    } else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }
}
