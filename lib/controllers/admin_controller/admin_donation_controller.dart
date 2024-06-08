import 'package:bankpfe/data/Model/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminDonationsController extends GetxController {
  fetchdata();
}

class AdminDonationsControllerImp extends AdminDonationsController {
  bool isloading = false;
  List<DonationModel> mydonations = [];
  @override
  Future fetchdata() async {
    try {
      isloading = true;
      update();

      QuerySnapshot donationsSnapshot =
          await FirebaseFirestore.instance.collection('Donations').get();

      mydonations.clear();
      for (var doc in donationsSnapshot.docs) {
        var donationdata = doc.data() as Map<String, dynamic>;
        donationdata['donation_id'] = doc.id;
        mydonations.add(DonationModel.fromJson(donationdata));
      }

      isloading = false;
      update();
    } catch (e) {
      return Get.rawSnackbar(
        title: "Error",
        message: "Please try again",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void onInit() {
    fetchdata();
    super.onInit();
  }
}
