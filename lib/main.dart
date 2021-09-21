import 'package:flutter/material.dart';
import 'package:health_app/config/route.dart';
import 'package:health_app/theme/theme.dart';
import 'package:health_app/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Health Care',
        theme: AppTheme.lightTheme,
        //routes: Routes.getRoute(),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const HomePage()
        });
  }
}
