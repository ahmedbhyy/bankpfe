

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String title;

  final String type;
  final String lottie;

  final double amount;

  final Timestamp date;

  TransactionModel( {
    required this.title,
    required this.lottie,
    required this.amount,
    required this.type,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      title: json['title'] ?? '',
      date: json['date'] ?? Timestamp.now(),
    lottie: json['lottie'] ?? '',
    amount: json['amount'] ?? 0.0,
    
      type: json['type'] ?? '',
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
     
      'amount': amount,
  
      'type': type,
      'lottie': lottie,
    
      'date': date,
    };
  }
}
