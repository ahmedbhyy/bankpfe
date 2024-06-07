import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminSendNotifitokenController extends GetxController {}

class AdminSendNotifitokenControllerImp extends AdminSendNotifitokenController {
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
