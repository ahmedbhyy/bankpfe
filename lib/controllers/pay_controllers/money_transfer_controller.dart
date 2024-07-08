import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../functions/auth_function.dart';
import '../../functions/sendnotification.dart';

abstract class MoneyTransferController extends GetxController {
  updateindex(int index);
  updateColor(int index);
  updatevalue(String value);
  verifyuser(double amount, String to, String accountid, double balance,
      String senderRibAccount);
}

class MoneyTransferControllerImp extends MoneyTransferController {
  MoneyTransferControllerImp() {
    choices = [
      {
        "myicon": const Icon(
          Icons.person_pin_circle_outlined,
          color: Colors.white,
        ),
        "mytitle": "Transfer to the same bank"
      },
      {
        "myicon": const Icon(
          Icons.account_balance_rounded,
          color: Colors.white,
        ),
        "mytitle": "Transfer to another bank"
      },
      {
        "myicon": const Icon(
          Icons.wifi_tethering_outlined,
          color: Colors.white,
        ),
        "mytitle": "international money transfer"
      },
    ];
    isSelectedList = List<bool>.filled(choices.length, false);
    isSelectedList[0] = true;
  }

  String? userid;
  String? username;
  TextEditingController cardnumber = TextEditingController();

  TextEditingController amount = TextEditingController();

  TextEditingController content = TextEditingController();
  TextEditingController cardaddnumber = TextEditingController();
  TextEditingController cardaddholder = TextEditingController();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  List choices = [];
  bool isloading = false;

  String? selectedItem;
  List<bool> isSelectedList = [];

  List<String> names = ["Slim Gharbi", "Karim Gharbi", "Mounir Gharbi"];
  List<String> numbers = ["5606", "6540454", "9078708"];

  int i = 0;

  GlobalKey<FormState> formStatemoneytransfer = GlobalKey<FormState>();
  GlobalKey<FormState> formStateaddcard = GlobalKey<FormState>();

  @override
  updateindex(index) {
    i = index;
    update();
  }

  @override
  void updateColor(index) {
    isSelectedList = List<bool>.filled(choices.length, false);
    isSelectedList[index] = !isSelectedList[index];
    update();
  }

  @override
  verifyuser(amount, to, accountid, balance, senderRibAccount) async {
    if (await authenticate1("Verification") == true) {
      try {
        isloading = true;
        update();
        QuerySnapshot receiverQuerySnapshot = await FirebaseFirestore.instance
            .collectionGroup('accounts')
            .where('accountcard.rib', isEqualTo: cardnumber.text)
            .get();

        if (cardnumber.text == senderRibAccount) {
          return Get.rawSnackbar(
              backgroundColor: const Color.fromARGB(255, 255, 0, 0),
              title: "Error",
              message: "you can't send money to your bank account!");
        }
        if (receiverQuerySnapshot.docs.isEmpty) {
          return Get.rawSnackbar(
              backgroundColor: const Color.fromARGB(255, 255, 0, 0),
              title: "Error",
              message: "Reciever not found!");
        } else {
          sendNotification(
              "BNA Send Money", "You have send $amount TND to $to");
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userid)
              .collection('accounts')
              .doc(accountid)
              .update({
            'accountcard.balance': balance - amount,
          });

          DocumentSnapshot receiverDoc = receiverQuerySnapshot.docs.first;
          DocumentReference receiverRef = receiverDoc.reference;
          double receiverBalance = receiverDoc.get('accountcard.balance');
          String receiverUserId = receiverDoc.reference.parent.parent!.id;
          receiverRef.update({
            'accountcard.balance': receiverBalance + amount,
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userid)
              .collection('transactions')
              .add({
            'amount': amount,
            'cardid': accountid,
            'category': "Transaction",
            'date': Timestamp.now(),
            'debit': "Debit",
            'internal': "FT245056540845646",
            'lottie': "images/lotties/lottie_minus.json",
            'title': "Send Money ($amount TND)",
            'transcationtype': "Opération monétiques",
            'type': "Transfer",
          });
           await FirebaseFirestore.instance
              .collection('users')
              .doc(receiverUserId)
              .collection('transactions')
              .add({
            'amount': amount,
            'cardid': receiverQuerySnapshot.docs.first.id,
            'category': "Transaction",
            'date': Timestamp.now(),
            'debit': "Credit",
            'internal': "FT245056540845646",
            'lottie': "images/lotties/lottie_added.json",
            'title': "Received Money ($amount TND)",
            'transactiontype': "Opération monétiques",
            'type': "Added",
          });
             isloading = false;
          update();
          Get.back();
          return Get.rawSnackbar(
              backgroundColor: const Color(0xff00aa86),
              title: "Success",
              message: "Transfer successfuly");
        }
      } catch (e) {
          isloading = false;
        update();
        Get.rawSnackbar(
            backgroundColor: const Color.fromARGB(255, 255, 0, 0),
            title: "Error",
            message: "Please try again!");
      }
    } else {
        isloading = false;
      update();
      Get.rawSnackbar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: "Error",
          message: "Not recognized");
    }
  }

  @override
  void onInit() async {
    userid = await secureStorage.read(key: "userid");
    username = await secureStorage.read(key: "username");
    update();
    super.onInit();
  }

  @override
  updatevalue(String value) {
    selectedItem = value;
    int z = names.indexOf(value);
    cardnumber.text = numbers[z];
    update();
  }
}
