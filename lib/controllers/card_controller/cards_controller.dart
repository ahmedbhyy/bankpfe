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
    update();
  }
}
