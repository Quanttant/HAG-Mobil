import 'package:confetti/confetti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Ayarlar'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)])),
          )),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).copyWith().size.width,
          child: FlatButton(
            child: Text(
              'Coded with 💙 in Turkey 🇹🇷',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            onLongPress: () => launch('https://quanttant.com/'),
            onPressed: () {
              _controllerTopCenter.stop();
              _controllerTopCenter.play();
            },
          ),
        ),
      ],
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffF8B133),
                        ),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          child: Text(
                            'Geri Bildirim Gönder',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          onPressed: () => Wiredash.of(context).show(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff6F6F6F),
                        ),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          child: Text(
                            'Kaynak Kod',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          onPressed: () => launch('https://github.com/Quanttant/HAG-Mobil'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient:
                              LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)]),
                        ),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          child: Text(
                            'Uygulama Hakkında',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          onPressed: () => showAlertDialog(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
              maxBlastForce: 5, // set a lower max blast force
              minBlastForce: 2, // set a lower min blast force
              emissionFrequency: 0.05,
              numberOfParticles: 50, // a lot of particles at once
              gravity: 1, colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      )),
    );
  }

  showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hangi Aşı Grubundayım", style: TextStyle(fontSize: 20)),
          content: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: [
                TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Montserrat'),
                  text: "Aşı grubu hesaplama algoritması ",
                ),
                TextSpan(
                  style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline, fontSize: 16, fontFamily: 'Montserrat'),
                  text: "hangiasigrubundayim.com",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url = 'https://hangiasigrubundayim.com/';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                ),
                TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Montserrat'),
                  text: "\'dan alınmıştır.\n\nGüncel aşılanan kişi sayısı verisi ",
                ),
                TextSpan(
                  style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline, fontSize: 16, fontFamily: 'Montserrat'),
                  text: "covid19asi.saglik.gov.tr",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url = 'https://covid19asi.saglik.gov.tr';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                ),
                TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Montserrat'),
                  text: "\'den alınmaktadır.",
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Tamam"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }
}
