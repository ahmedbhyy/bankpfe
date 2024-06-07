import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String useremail;
  final String repport;
  final String userid;
  final Timestamp reportdate;

  ReportModel({
    required this.useremail,
    required this.repport,
    required this.userid,
    required this.reportdate,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      useremail: json['useremail'] ?? '',
      repport: json['report'] ?? '',
      userid: json['userid'] ?? '',
      reportdate: json['report_date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'useremail': useremail,
      'report': repport,
      'userid': userid,
      'report_date': reportdate,
    };
  }
}
