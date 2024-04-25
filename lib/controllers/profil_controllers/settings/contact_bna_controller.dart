import 'dart:async';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class ContactBnaController extends GetxController {
  launchurl(Uri url);
  callphone(String phone);
}

class ContactBnaControllerImp extends ContactBnaController {
  int currectindex = 0;
  late Timer timer;

  List<String> lottiesbna = [
    "lottie_fb",
    "lottie_instagram",
    "lottie_web2",
    "lottie_phone"
  ];
  List<String> bnaimages = ["bna1", "bna2", "bna3"];
  List<String> bnaurl = [
    "https://www.facebook.com/BanqueNationaleAgricole",
    "https://www.instagram.com/bna.bank/",
    "http://www.bna.tn/",
    "71831000"
  ];

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      currectindex = (currectindex + 1) % bnaimages.length;
      update();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  launchurl(url) async {
   
    if (!await launchUrl(url)) {
      Get.snackbar("Error", "Please try again later !");
    }
   
  }

  @override
  callphone(String phone) async {
   
    if (!await launchUrlString("tel://$phone")) {
      Get.snackbar("Error", "Please try again later !");
    }
    
  }
}
