import 'package:get/get.dart';

abstract class MobileController extends GetxController {}

class MobileControllerImp extends MobileController {
  List<String> userinfo = [
    "Operator",
    "Card",
    "Phone number",
    "code",
    "Date",
    "Amount",
  ];
}
