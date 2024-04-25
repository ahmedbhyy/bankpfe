import 'package:get/get.dart';

abstract class AllTransactionController extends GetxController {
  updatecolor();
}

class AllTransactionControllerImp extends AllTransactionController {
  bool isselected = false;
  @override
  updatecolor() {
    isselected = !isselected;
    update();
  }
}
