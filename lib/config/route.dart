import 'package:flutter/material.dart';
import 'package:health_app/pages/home_page.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => HomePage(),
    };
  }
}
