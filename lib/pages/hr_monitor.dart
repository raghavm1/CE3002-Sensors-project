import 'package:flutter/material.dart';
import 'package:health_app/theme/extention.dart';
import 'package:health_app/theme/light_color.dart';
import 'package:health_app/theme/text_styles.dart';
import 'package:health_app/theme/theme.dart';

/*
class HeartRoute extends StatelessWidget {
  const HeartRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  HRPage()),
            );
          },
        ),
      ),
    );
  }
}
*/
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
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: LightColor.grey,
          ),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ));
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
