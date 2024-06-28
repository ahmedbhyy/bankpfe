import 'package:bankpfe/data/Model/card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  final String accountnumber;
  final Timestamp creationdate;
  final CardModel accountcard;
  String id;

  AccountModel({
    required this.id,
    required this.accountcard,
    required this.accountnumber,
    required this.creationdate,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] ?? '',
    accountcard: CardModel.fromJson(json['accountcard']),
     
      accountnumber: json['accountnumber'] ?? "",
      creationdate: json['creationdate'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountnumber': accountnumber,
      'creationdate': creationdate,
      'accountcard': accountcard
    };
  }
}
