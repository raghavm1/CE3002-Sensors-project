import 'package:flutter/material.dart';
import 'package:health_app/theme/extention.dart';
import 'package:health_app/theme/light_color.dart';
import 'package:health_app/theme/text_styles.dart';
import 'package:health_app/theme/theme.dart';
import 'package:charts_flutter/flutter.dart';

class HRPage extends StatefulWidget {
  HRPage({Key? key}) : super(key: key);

  @override
  _HRPageState createState() => _HRPageState();
}

class _HRPageState extends State<HRPage> {
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: const Icon(
        Icons.arrow_back,
        size: 30,
        color: LightColor.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: _appBar(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      //body:  //add body here
    );
  }
}
