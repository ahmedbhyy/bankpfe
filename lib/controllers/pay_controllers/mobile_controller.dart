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

  List<String> mobilebill = [
    "Orange",
    "Card 1",
    "90 178 100",
    "MGIO2540",
    "Yesterday",
    "25.0",
  ];
}
