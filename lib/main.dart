import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hag/pages/splash_page.dart';
import 'package:wiredash/wiredash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Wiredash(
      projectId: 'hangi-asi-grubundayim-n3c4e0k',
      secret: 'v2rlyf1ko3n38niusjnncyh2fcezx6hlnl7omhppk3nwcrqv',
      navigatorKey: _navigatorKey,
      options: WiredashOptionsData(
        locale: const Locale('tr'),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        title: 'Hangi Aşı Grubundayım',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          accentColor: Color(0xff00B8C0),
          backgroundColor: Colors.white,
        ),
        home: SplashPage(),
      ),
    );
  }
}
