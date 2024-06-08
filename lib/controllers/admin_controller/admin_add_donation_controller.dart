import 'package:bankpfe/functions/sendnotification.dart';
import 'package:bankpfe/screens/homescreens/admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SampleItem { itemone, itemTwo, itemThree, itemFour }

abstract class AdminDonationsAddController extends GetxController {
  adddonation();
}

class AdminDonationsAddControllerImp extends AdminDonationsAddController {
  TextEditingController? title;
  TextEditingController? description;
  TextEditingController? totalamount;
  TextEditingController? place;
  TextEditingController? orgonizedby;
  TextEditingController? orgonizedbylink;
  TextEditingController? orgonizedbydescription;
  TextEditingController? orgonizedbyimage;
  TextEditingController? type;
  TextEditingController? days;
  TextEditingController? donationimage;
  GlobalKey<FormState> donationkey = GlobalKey<FormState>();

  SampleItem? selectedItem;

  List<SampleItem> sampleitemlisty = [
    SampleItem.itemone,
    SampleItem.itemTwo,
    SampleItem.itemThree,
    SampleItem.itemFour,
  ];

  List<String> names = ["Disasters", "Palestine", "Health", "Education"];

  @override
  void onInit() {
    title = TextEditingController();
    description = TextEditingController();
    totalamount = TextEditingController();
    place = TextEditingController();
    orgonizedby = TextEditingController();
    orgonizedbydescription = TextEditingController();
    orgonizedbyimage = TextEditingController();
    orgonizedbylink = TextEditingController();
    type = TextEditingController();
    days = TextEditingController();
    donationimage = TextEditingController();
    super.onInit();
  }

  @override
  adddonation() async {
    try {
      await FirebaseFirestore.instance.collection('Donations').add({
        'type': type!.text,
        'totalamount': double.parse(totalamount!.text),
        'title': title!.text,
        'description': description!.text,
        'place': place!.text,
        'orgonizedbylink': orgonizedbylink!.text,
        'orgonizedbyimage': orgonizedbyimage!.text,
        'orgonizedbydescription': orgonizedbydescription!.text,
        'orgonizedby': orgonizedby!.text,
        'givers': 0,
        'donationimage': donationimage!.text,
        'daysleft': double.parse(days!.text),
        'currentamount': 0.0,
      });
      Get.offAll(const AdminPage());
      sendNotification(
          "Donations", "a new donation has been added, check it !");
      return Get.rawSnackbar(
          backgroundColor: const Color(0xff00aa86),
          title: "Success",
          message: "We have added a new donation");
    } catch (e) {
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Please try again.");
    }
  }
}
