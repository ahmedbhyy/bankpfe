import 'dart:convert';
import 'package:bankpfe/functions/auth_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

Future<void> sendNotification(
    String title, String description) async {
  var headersList = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'key=AAAAAqvRi_w:APA91bGGxFyUZZhHhQHWMn-Zlh3jo6ZvRzNcifxT369TJLer0QCcQXLQgrgL-rcaCJ04ifnFPTEHi-xmS4daFH0FsOovXGaj5Yz6y1A_lE_Bi5MXT-X3Vh9t9vAqAGjsOjGhCexCD9lm'
  };

  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to": "/topics/BNA", 
    "notification": {
      "title": title,
      "body": description,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUsv3FUY2F0v-RzXNqV76JTjJf6UaZgpNQYWIA2M20Kg&s",
    },
  };
    String? userid = await secureStorage.read(key: "userid");
  DocumentReference userDocRef =
      FirebaseFirestore.instance.collection('users').doc(userid);

  await userDocRef.collection('notifications').add({
    'title': title,
    'details': description,
    'date': Timestamp.now(),
    
  });

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    return;
  } else {
     return;
  }
}
