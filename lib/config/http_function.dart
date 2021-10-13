// import 'package:http/http.dart';
//
// fetchData(String data) async {
//   http.Response response = await http.get(Uri.parse(http://0.0.0.0:8000/));
//   return response.body;
// }

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

getHData() async {
   http.Response response = await http.get(Uri.parse('http://10.0.2.2:5000'));
  return response.body;
}

Future<HeartData> fetchHeartbeat() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:5000'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return HeartData.returnString(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HeartData {

  final String title;

  HeartData({
    required this.title,
  });

  factory HeartData.returnString(String string) {
    return HeartData(
      title: string
    );
  }
}