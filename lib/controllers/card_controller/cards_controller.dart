import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class CardsController extends GetxController {
  void updatecolor(bool value);
  void updatefavorite(bool value);
}

class CardsControllerImp extends CardsController {
  bool light0 = true;
  bool favorite = false;

  @override
  updatecolor(value) {
    light0 = value;
    update();
  }

  @override
  updatefavorite(value) {
    favorite = value;
    value == true
        ? Get.rawSnackbar(
            title: "Favorite Card",
            message:
                "this card will be the favorite card which with it you can pay the bills",
            backgroundColor: const Color(0xff00aa86),
          )
        : Get.rawSnackbar(
            title: "Normal Card",
            message:
                "the other card will be the favorite card which with it you can pay the bills",
            backgroundColor: const Color(0xff00aa86),
          );
    update();
  }
}
