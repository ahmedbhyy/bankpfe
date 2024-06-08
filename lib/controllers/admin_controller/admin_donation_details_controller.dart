import 'package:bankpfe/screens/homescreens/admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminDonationsDetailsController extends GetxController {
  deletedontaion(String donationid);
}

class AdminDonationsDetailsControllerImp
    extends AdminDonationsDetailsController {
  @override
  deletedontaion(String donationid) async {
    try {
      await FirebaseFirestore.instance
          .collection('Donations')
          .doc(donationid)
          .delete();
      Get.offAll(const AdminPage());
      Get.rawSnackbar(
        title: "Success",
        message: "You have deleted this Donation",
        backgroundColor: Colors.green,
      );
      update();
    } catch (e) {
      return Get.rawSnackbar(
        title: "Error",
        message: "Please try again",
        backgroundColor: Colors.red,
      );
    }
  }
}
