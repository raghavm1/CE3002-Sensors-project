// import 'package:http/http.dart';
//
// fetchData(String data) async {
//   http.Response response = await http.get(Uri.parse(http://0.0.0.0:8000/));
//   return response.body;
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import "package:universal_html/html.dart" as html;
import 'package:sse_client/sse_client.dart';

class Sse {
  final html.EventSource eventSource;
  final StreamController<String> streamController;

  Sse._internal(this.eventSource, this.streamController);

  factory Sse.connect({
    required Uri uri,
    bool withCredentials = false,
    bool closeOnError = true,
  }) {
    final streamController = StreamController<String>();
    final eventSource =
        html.EventSource(uri.toString(), withCredentials: withCredentials);
    debugPrint("Conn");
    eventSource.addEventListener('message', (html.Event message) {
      debugPrint("rece");
      streamController.add((message as html.MessageEvent).data as String);
    });

    eventSource.addEventListener('message', (e) {
      debugPrint("rece");
      streamController.add((e as html.MessageEvent).data as String);
    });

    ///close if the endpoint is not working
    if (closeOnError) {
      eventSource.onError.listen((event) {
        eventSource.close();
        streamController.close();
      });
    }
    return Sse._internal(eventSource, streamController);
  }

  Stream get stream => streamController.stream;

  bool isClosed() =>
      this.streamController == null || this.streamController.isClosed;

  void close() {
    this.eventSource.close();
    this.streamController.close();
  }
}

class HeartData {
  final String title;

  HeartData({
    required this.title,
  });

  factory HeartData.returnString(String string) {
    return HeartData(title: string);
  }
}
