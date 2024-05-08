import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  final String title;
  final String type;
  final bool ispayed;
  final String card;
  final String code;
  final String image;
  final double amount;
  final Timestamp date;
  BillModel({
    required this.title,
    required this.card,
    required this.ispayed,
    required this.code,
    required this.image,
    required this.amount,
    required this.type,
    required this.date,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      title: json['title'] ?? '',
      ispayed: json['ispayed'] ?? false,
      date: json['date'] ?? Timestamp.now(),
      image: json['image'] ?? '',
      amount: json['amount'] ?? 0.0,
      card: json['card'] ?? "M432432R324",
      code: json['code'] ?? "263424582",
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ispayed': ispayed,
      'amount': amount,
      'type': type,
      'image': image,
      'date': date,
      'card': card,
      'code': code,
    };
  }
}
