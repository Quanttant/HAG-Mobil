import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hag/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Hangi Aşı Grubundayım',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        accentColor: Color(0xff00B8C0),
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
