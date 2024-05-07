import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';

abstract class AllBillsDetailsController extends GetxController {
  payelectric();
}

class AllBillsDetailsControllerImp extends AllBillsDetailsController {
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
    if (await authenticate1("Verification") == true) {
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
