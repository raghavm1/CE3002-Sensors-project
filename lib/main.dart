import 'package:flutter/material.dart';
import 'package:health_app/config/route.dart';
import 'package:health_app/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care',
      theme: AppTheme.lightTheme,
      routes: Routes.getRoute(),
      debugShowCheckedModeBanner: false,
      initialRoute: "HomePage",
    );
  }
}
