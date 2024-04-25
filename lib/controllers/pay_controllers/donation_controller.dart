import 'package:bankpfe/data/Model/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DonationController extends GetxController {
  updateColor(int index);
  fetchdonations();
  List<DonationModel> choosecategories(String categorie);
}

class DonationControllerImp extends DonationController {
  String donationtitle = "All";
  bool isloading = false;
  DonationControllerImp() {
    categoriesdonation = [
      {
        "myicon": const Icon(
          Icons.all_inbox,
          color: Colors.white,
        ),
        "mytitle": "All"
      },
      {
        "myicon": const Icon(
          Icons.cast_for_education,
          color: Colors.white,
        ),
        "mytitle": "Education"
      },
      {
        "myicon": const Icon(
          Icons.health_and_safety_outlined,
          color: Colors.white,
        ),
        "mytitle": "Health"
      },
      {
        "myicon": const Icon(
          Icons.personal_injury_outlined,
          color: Colors.white,
        ),
        "mytitle": "Disasters"
      },
      {
        "myicon": const Icon(
          Icons.family_restroom_sharp,
          color: Colors.white,
        ),
        "mytitle": "Palestine"
      },
      {
        "myicon": const Icon(
          Icons.wb_incandescent_sharp,
          color: Colors.white,
        ),
        "mytitle": "Fundraising"
      },
    ];
    isSelectedList = List<bool>.filled(categoriesdonation.length, false);
    isSelectedList[0] = true;
  }
  List<Map> categoriesdonation = [];
  List<DonationModel> donations = [];
  List<bool> isSelectedList = [];

  @override
  void onInit() {
    fetchdonations();
    choosecategories(donationtitle);
    super.onInit();
  }

  @override
  void updateColor(index) {
    isSelectedList = List<bool>.filled(categoriesdonation.length, false);
    isSelectedList[index] = !isSelectedList[index];
    donationtitle = categoriesdonation[index]["mytitle"];
    update();
  }

  @override
  Future fetchdonations() async {
    try {
      isloading = true;
      update();

      QuerySnapshot donationsSnapshot =
          await FirebaseFirestore.instance.collection('Donations').get();

      donations.clear();
      for (var doc in donationsSnapshot.docs) {
        donations
            .add(DonationModel.fromJson(doc.data() as Map<String, dynamic>));
      }

      isloading = false;
      update();
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again",
          backgroundColor: Colors.red);
    }
  }

  @override
  choosecategories(categorie) {
    if (categorie == "All") {
      return donations;
    } else {
      List<DonationModel> donationscategories = [];
      for (DonationModel donation in donations) {
        if (donation.type == categorie) {
          donationscategories.add(donation);
        }
      }
      return donationscategories;
    }
  }
}
