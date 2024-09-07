import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String token;
  final String cin;
  final bool isadmin;
  final Timestamp birthdaydate;
  final String username;
  final String phone;
  final String userid;

  UserModel({
    required this.email,
    required this.token,
    required this.cin,
    required this.isadmin,
    required this.birthdaydate,
    required this.phone,
    required this.username,
    required this.userid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['user_email'] ?? '',
      cin: json['cin']??'',
      token: json['token'] ?? '',
      isadmin: json['isadmin'] ?? false,
      birthdaydate: json['birthdaydate'] ?? Timestamp.now(),
      phone: json['phone'] ?? "",
      username: json['name'] ?? "member",
      userid: json['user_id'] ?? "0"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isadmin': isadmin,
      'cin':cin,
      'token': token,
      'user_email': email,
      'name': username,
      'birthdaydate': birthdaydate,
      'phone': phone,
      'user_id' :userid,
    };
  }
}
