import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hms_gms_availability/flutter_hms_gms_availability.dart';
import 'package:hag/pages/photoview_page.dart';
import 'package:screenshot/screenshot.dart';
import 'calculation_page.dart';
import 'package:path_provider/path_provider.dart';

class ResultPage extends StatefulWidget {
  ResultPage({@required this.result});

  final DropdownModel result;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;
  bool gms, hms;

  @override
  void initState() {
    super.initState();
    FlutterHmsGmsAvailability.isGmsAvailable.then((t) {
      setState(() {
        gms = t;
      });
    });
    FlutterHmsGmsAvailability.isHmsAvailable.then((t) {
      setState(() {
        hms = t;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title: Text('Sonuç'),
          actions: [IconButton(icon: Icon(Icons.share), onPressed: () => shareResult())],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)])),
          )),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  color: Colors.white,
                  child: Screenshot(
                    controller: screenshotController,
                    child: Card(
                      color: Color(0xff00B8C0),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Center(
                                    child: Text(
                              widget.result.queue.isNotEmpty
                                  ? '${widget.result.priority}. aşı grubunda ${widget.result.queue} sırasındasın'
                                  : '${widget.result.priority}. aşı grubundasın',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                            ))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo-transparent.png',
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'Hangi Aşı Grubundasın',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)]),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sonucu Paylaş',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.share, color: Colors.white),
                      ],
                    ),
                    onPressed: () => shareResult(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    color: Color(0xff0F344E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      'COVID-19 Aşısı Uygulanacak Kişiler',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PhotoViewPage(
                            title: 'COVID-19 Aşısı Uygulanacak Kişiler',
                            imgUrl: 'assets/images/asi-tablo.png',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  shareResult() async {
    _imageFile = null;
    screenshotController.capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0).then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      String storeLink = gms ? 'https://play.google.com/store/apps/details?id=com.quanttant.hag' : 'https://appgallery.huawei.com/#/app/C103691603';
      String desc = '\n\nSen de hangi aşı grubunda olduğunu merak ediyorsan 👇 \n\n$storeLink';
      String message = widget.result.queue != null
          ? '${widget.result.priority}. aşı grubunda ${widget.result.queue} sırasındayım. $desc'
          : '${widget.result.priority} Aşı grubundayım. $desc';
      await Share.file('', 'screenshot.png', pngBytes, 'image/png', text: message);
    }).catchError((onError) {
      print(onError);
    });
  }
}
