import 'package:bankpfe/data/Model/report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminReportsController extends GetxController {
  fetchdata();
}

class AdminReportsControllerImp extends AdminReportsController {
  bool isloading = false;
  List<ReportModel> myreports = [];
  @override
  Future fetchdata() async {
    try {
      isloading = true;
      update();

      QuerySnapshot donationsSnapshot =
          await FirebaseFirestore.instance.collection('reports').get();

      myreports.clear();
      for (var doc in donationsSnapshot.docs) {
        myreports.add(ReportModel.fromJson(doc.data() as Map<String, dynamic>));
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
