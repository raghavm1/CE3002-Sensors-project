import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_app/theme/extention.dart';
import 'package:health_app/theme/light_color.dart';
import 'package:health_app/theme/text_styles.dart';
import 'package:health_app/theme/theme.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:http/http.dart' as http;
import 'chart.dart';
import 'package:health_app/config/http_function.dart';

class HRPage extends StatefulWidget {
  HRPage({Key? key}) : super(key: key);

  @override
  _HRPageState createState() => _HRPageState();
}

class _HRPageState extends State<HRPage> {
  bool _toggled = false;
  List<SensorValue> _data = [];
  double _alpha = 0.3;
  bool _processing = false;
  int _bpm = 0;

  late Stream myStream;
  late Timer timer;
  String _bpmString = "";
  // _updateBPM() async {
  //   List<SensorValue> _values;
  //   double _avg;
  //   int _n;
  //   double _m;
  //   double _threshold;
  //   double _bpm;
  //   int _counter;
  //   int _previous;
  //   while (_toggled) {
  //     _values = List.from(_data);
  //     _avg = 0;
  //     _n = _values.length;
  //     _m = 0;
  //     _values.forEach((SensorValue value) {
  //       _avg += value.value / _n;
  //       if (value.value > _m) _m = value.value;
  //     });
  //     _threshold = (_m + _avg) / 2;
  //     _bpm = 0;
  //     _counter = 0;
  //     _previous = 0;
  //     for (int i = 1; i < _n; i++) {
  //       if (_values[i - 1].value < _threshold &&
  //           _values[i].value > _threshold) {
  //         if (_previous != 0) {
  //           _counter++;
  //           _bpm +=
  //               60000 / (_values[i].time.millisecondsSinceEpoch - _previous);
  //         }
  //         _previous = _values[i].time.millisecondsSinceEpoch;
  //       }
  //     }
  //     if (_counter > 0) {
  //       _bpm = _bpm / _counter;
  //       setState(() {
  //         _bpm = (1 - _alpha) * _bpm + _alpha * _bpm;
  //       });
  //     }
  //     await Future.delayed(Duration(milliseconds: (1000 * 50 / 30).round()));
  //   }
  // }

  _toggle() {
    setState(() {
      _toggled = !_toggled;
    });
  }

  Widget _appBar() {
    return AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            size: 40,
            color: LightColor.grey,
          ),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    var data = '';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: _appBar(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  color: Colors.red,
                  child: Center(
                      child: Text(
                    ("BPM: " + _bpmString),
                    style: const TextStyle(
                        fontSize: 46, fontWeight: FontWeight.bold),
                  ))),
            ),
            Expanded(
              child: Center(
                child: IconButton(
                  icon: Icon(_toggled ? Icons.favorite : Icons.favorite_border),
                  color: Colors.red,
                  iconSize: 128,
                  onPressed: () {
                    _toggle();
                    if (_toggled) {
                      //debugPrint("Tog");
                      timer = Timer.periodic(
                          Duration(milliseconds: 500), (Timer t) => {req()});
                    } else {
                      //debugPrint("TogN");
                      _bpmString = "--";
                      timer.cancel();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: Colors.black),
                //child: Chart(_data),
              ),
            ),
          ],
        ),
      ), //body:  //add body here
    );
  }

  void testSse() {
    myStream = Sse.connect(
      uri: Uri.parse('http://localhost:5000/bpm'),
      closeOnError: true,
      withCredentials: false,
    ).stream;

    myStream.listen((event) {
      debugPrint('Received:' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          ' : ' +
          event.toString());
    });
  }

  void req() async {
    final r = await http.get(Uri.parse("http://10.0.2.2:5000/bpmReq"));
    if (r.statusCode == 200) {
      debugPrint(jsonDecode(r.body)["data"]);
      setState(() {
        _bpmString = jsonDecode(r.body)["data"];
      });
    }
  }
}
