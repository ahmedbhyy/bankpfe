import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';

abstract class PayMobileController extends GetxController {
  updateindex(int index);
  updateimage(String text);
  updateindexz(int index);
  paymobilebill();
}

class PayMobileControllerImp extends PayMobileController {
  TextEditingController phonenumber = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  int i = 0;
  int j = 0;
  int z = 0;
  List cardsdetails = [
    {
      "name1": "bnacard",
      "amount": 350.000,
      "holdername": "Ahmed belhajyahia",
      "cardnumber": "1121090606",
      "background": "images/background1.jpg",
    },
    {
      "name1": "bnacard2",
      "amount": 520.000,
      "holdername": "slim rkik",
      "cardnumber": "545066504",
      "background": "images/background2.jpg",
    }
  ];
  List<String> amounts = [
    "10 TND",
    "20 TND",
    "25 TND",
    "30 TND",
    "35 TND",
    "40 TND",
  ];
  List<Widget> mywidgets = [
    const Text("write your phone number"),
    Image.asset(
      "images/orange.png",
      height: 30.0,
    ),
    Image.asset(
      "images/tt.png",
      height: 30.0,
    ),
    Image.asset(
      "images/ooredoo.png",
      height: 30.0,
    ),
    const Text("verify your phone number"),
  ];
  @override
  updateindexz(index) {
    z = index;
    update();
  }

  @override
  updateindex(index) {
    i = index;
    update();
  }

  @override
  updateimage(text) {
    if (text.isEmpty || text.length != 8 || !text.isNumericOnly) {
      j = 0;
      update();
    } else if (text[0] == '5') {
      j = 1;
      update();
    } else if (text[0] == '9') {
      j = 2;
      update();
    } else if (text[0] == '2') {
      j = 3;
      update();
    } else {
      j = 4;
      update();
    }
  }

  @override
  paymobilebill() async {
    if (await authenticate1("Verification") == true) {
      Get.back();
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success", message: "You have payed your mobile bill");
    } else {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }

  @override
  void dispose() {
    phonenumber.dispose();
    super.dispose();
  }
}
