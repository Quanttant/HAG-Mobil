import 'package:flutter/material.dart';
import 'package:hag/network/network_manager.dart';
import 'package:hag/network/vaccine_response.dart';
import 'package:hag/pages/calculation_page.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('tr');

  Future<VaccineReponse> getStats() async {
    var res = await NetworkManager.getVaccineStats();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Hangi Aşı Grubundayım'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)])),
          )),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Color(0xff00B8C0),
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                futureBuilder(),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)]),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text(
                        'Aşı Grubu Hesaplama',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalculationPage())),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                        'Ayarlar',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onPressed: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardWidget(String title, int count) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)])),
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
              title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            )),
          ),
          Container(
            decoration: BoxDecoration(color: Color(0xff6F6F6F)),
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Center(
              child: Text(
                numberFormat.format(count),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget noInternet() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 48,
          ),
          SizedBox(
            height: 20,
          ),
          Text('İnternet bağlantınız yok.'),
        ],
      ),
    );
  }

  Widget futureBuilder() {
    return FutureBuilder<VaccineReponse>(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return noInternet();
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Veriler yükleniyor...'),
                  SizedBox(
                    height: 50,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
            break;
          default:
            if (snapshot.hasData && !snapshot.hasError) {
              return Column(
                children: [
                  cardWidget('Toplam Aşılanan Kişi Sayısı', snapshot.data.total),
                  SizedBox(
                    height: 40,
                  ),
                  cardWidget('Bugün Aşılanan Kişi Sayısı', snapshot.data.today),
                ],
              );
            } else
              return noInternet();
        }
      },
      future: getStats(),
    );
  }
}
