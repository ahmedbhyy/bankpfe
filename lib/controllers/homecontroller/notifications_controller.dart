import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NotificationsController extends GetxController {
  fetchUserDataNotifications();
  deleteusernotifications(String id, int index);
  deleteallnoti();
}

class NotificationsControllerImp extends NotificationsController {
  bool isloading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> userData = [];
  @override
  void onInit() {
    _user = _auth.currentUser!;
    fetchUserDataNotifications();
    update();
    super.onInit();
  }

  @override
  Future fetchUserDataNotifications() async {
    try {
      isloading = true;
      update();
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(_user.uid).get();

      if (docSnapshot.exists) {
        QuerySnapshot notificationsSnapshot =
            await docSnapshot.reference.collection('notifications').get();

        userData.clear();
        for (var doc in notificationsSnapshot.docs) {
          Map<String, dynamic> notificationData =
              doc.data() as Map<String, dynamic>;
          notificationData['id'] = doc.id;
          userData.add(notificationData);
        }
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
  Future deleteusernotifications(id, index) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection('notifications')
          .doc(id)
          .delete();

      userData.removeAt(index);
      Get.rawSnackbar(
          title: "Success",
          message: "You have deleted  this notifications",
          backgroundColor: Colors.green);
      update();
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again",
          backgroundColor: Colors.red);
    }
  }

  @override
  deleteallnoti() async {
    try {
      Get.back();
      userData.clear();
      Get.rawSnackbar(
          title: "Success",
          message: "You have deleted all the notifications",
          backgroundColor: Colors.green);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection('notifications')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      update();
    } catch (e) {
      return Get.rawSnackbar(
          title: "Error",
          message: "Please try again",
          backgroundColor: Colors.red);
    }
  }
}
