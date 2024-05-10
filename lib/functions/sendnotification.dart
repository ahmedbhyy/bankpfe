import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendNotification(
    String title, String description, String token) async {
  var headersList = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'key=YOUR_SERVER_KEY_HERE'
  };

  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to": token, 
    "notification": {
      "title": title,
      "body": description,
    },
  };

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
