import 'package:bankpfe/screens/homescreens/admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminDonationsDetailsController extends GetxController {
  deletedontaion(String donationid);
  editdonation(String donationid, String fielddonation, dynamic newvalue);
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

  TextEditingController? editcontroller;
  @override
  void onInit() {
    editcontroller = TextEditingController();
    super.onInit();
  }

  @override
  editdonation(String donationid, String fielddonation, newvalue) async {
    try {
      await FirebaseFirestore.instance
          .collection('Donations')
          .doc(donationid)
          .update(
        {fielddonation: newvalue},
      );
      SetOptions(merge: true);
      Get.offAll(const AdminPage());
    } catch (e) {
      return Get.rawSnackbar(
        title: "Error",
        message: "Please try again",
        backgroundColor: Colors.red,
      );
    }
  }
}
