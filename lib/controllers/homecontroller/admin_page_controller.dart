import 'package:bankpfe/data/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AdminPageController extends GetxController {
  fetchdata();
  searchclient(String name);
  logout();
}

class AdminPageControllerImp extends AdminPageController {
  bool isloading = false;
  List<UserModel> users = [];
  String search = "";
  TextEditingController? searchcontroller;

  @override
  Future fetchdata() async {
    try {
      isloading = true;
      update();

      QuerySnapshot donationsSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      users.clear();
      for (var doc in donationsSnapshot.docs) {
        var usersdata = doc.data() as Map<String, dynamic>;
        usersdata['user_id'] = doc.id;
        users.add(UserModel.fromJson(usersdata));
      }
      users.removeWhere((element) => element.isadmin == true);
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
    searchcontroller = TextEditingController();
    fetchdata();
    super.onInit();
  }

  @override
  List<UserModel> searchclient(String name) {
    List<UserModel> result;
    if (name.isEmpty) {
      result = users;
    } else {
      result =
          users.where((element) => element.username.contains(name)).toList();
    }
    update();
    return result;
  }

  @override
  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed("/signin");
    } catch (e) {
      return;
    }
  }
}
