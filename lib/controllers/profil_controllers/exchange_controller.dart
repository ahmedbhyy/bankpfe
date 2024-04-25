import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ExchangeController extends GetxController {
  choosefrom();

  updateamount(String amountt);
  exchangecurrency(from, to);
}

class ExchangeControllerImp extends ExchangeController {
  TextEditingController fromcontroller = TextEditingController();
  TextEditingController to = TextEditingController();

  Currency currecyfrom = Currency.usd;
  Currency currecyto = Currency.tnd;
  String money = "1";
  double amount = 1.0;
  double convert = 3.32;
  double convert1 = 3.32;
  bool isloading = false;
  @override
  exchangecurrency(from, to) async {
    if (fromcontroller.text.isNotEmpty) {
      amount = double.parse(fromcontroller.text);
    }
    isloading = true;
    update();
    var convertresult = await CurrencyConverter.convert(
      from: currecyfrom,
      to: currecyto,
      amount: amount,
    );
    var convertresultfor1 = await CurrencyConverter.convert(
      from: currecyfrom,
      to: currecyto,
      amount: 1.0,
    );
    convert1 = convertresultfor1!.toDouble();
    convert = convertresult!.toDouble();
    isloading = false;
    update();
  }

  @override
  choosefrom() {
    currecyfrom == Currency.eur
        ? currecyfrom = Currency.usd
        : currecyfrom = Currency.eur;
    update();
  }

  @override
  updateamount(amountt) {
    money = amountt;
    update();
  }
}
