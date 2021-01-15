import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'calculation_page.dart';

class ResultPage extends StatefulWidget {
  ResultPage({@required this.result});

  final DropdownModel result;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Sonuçlar'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)])),
          )),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Öncelik Grubunuz: ${widget.result.priority}'),
              Text('Sıra Numarası: ${widget.result.queue}'),
            ],
          ),
        ),
      ),
    );
  }
}
