import 'package:get/get.dart';

abstract class TransactionDetailsController extends GetxController {}

class TransactionDetailsControllerImp extends TransactionDetailsController {
  List<String> transactioninfo = [
    "Category",
    "Transaction Type",
    "Debit/Credit",
    "Transaction label",
    "Internal reference",
    "Booking date",
    "Value date",
    "Amount",
  ];
}
