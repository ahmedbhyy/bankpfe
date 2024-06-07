import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminSendNotifiController extends GetxController {}

class AdminSendNotifiControllerImp extends AdminSendNotifiController {
  TextEditingController? notificationtitle;
  TextEditingController? notificationdescription;
   GlobalKey<FormState> formStatenotification = GlobalKey<FormState>();
  
  @override
  void onInit() {
    notificationdescription = TextEditingController();
    notificationtitle = TextEditingController();
    super.onInit();
  }
}
