import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String title;
  final String type;
  final String category;
  final String transcationtype;
  final String debit;
  final String transactionlabel;
  final String internal;
  final String lottie;
  final double amount;
  final Timestamp date;
  final String cardid;
  TransactionModel( {
    required this.title,
    required this.category,
    required this.transcationtype,
    required this.debit,
    required this.transactionlabel,
    required this.internal,
    required this.lottie,
    required this.amount,
    required this.type,
    required this.date,
    required this.cardid,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      title: json['title'] ?? '',
      date: json['date'] ?? Timestamp.now(),
      lottie: json['lottie'] ?? '',
      amount: json['amount'] ?? 0.0,
      category: json['category'] ?? "Billed Transaction",
      transactionlabel: json['title'] ?? "",
      transcationtype: json['transcationtype'] ?? "Opération monétiques",
      debit: json['debit'] ?? "Debit",
      internal: json['internal'] ?? "",
      type: json['type'] ?? '',
      cardid: json['cardid']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'type': type,
      'lottie': lottie,
      'date': date,
      'category': category,
      'transactionlabel': transactionlabel,
      'transcationtype': transcationtype,
      'internal': internal,
      'debit': debit,
      'cardid':cardid,
    };
  }
}
