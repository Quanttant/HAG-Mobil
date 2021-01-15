import 'package:flutter/material.dart';
import 'package:hag/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3))
        .then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF18C4B8), Color(0xFF00B8C0)]),
        ),
        child: SafeArea(
            child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Image.asset(
                  'assets/logo-transparent.png',
                  scale: 2,
                ),
              ),
              Center(
                child: Text(
                  'Hangi Aşı Grubundayım',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30, height: 2),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: InkWell(
                  onTap: () => launch('https://quanttant.com/'),
                  child: Text(
                    'Powered by Quanttant',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
