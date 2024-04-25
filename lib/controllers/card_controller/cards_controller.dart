import 'package:get/get.dart';

abstract class CardsController extends GetxController {
  void updatecolor(bool value);
}

class CardsControllerImp extends CardsController {
  bool light0 = true;

  @override
  updatecolor(value) {
    light0 = value;
    update();
  }
}
