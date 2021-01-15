import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hag/pages/result_page.dart';

class CalculationPage extends StatefulWidget {
  CalculationPage({Key key}) : super(key: key);

  @override
  _CalculationPageState createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  List<DropdownModel> jobList = List<DropdownModel>.from([
    {"id": 0, "type": "Sağlık Çalışanı", "priority": 1, "queue": "A"},
    {"id": 1, "type": "Tıp Öğrencisi", "priority": 1, "queue": "A"},
    {"id": 2, "type": "Eczacı", "priority": 1, "queue": "A"},
    {"id": 3, "type": "Diş Hekimi", "priority": 1, "queue": "A"},
    {"id": 4, "type": "Diş Hekimliği Öğrencisi", "priority": 1, "queue": "A"},
    {"id": 5, "type": "Bakım Evi Çalışanı", "priority": 1, "queue": "B"},
    {"id": 6, "type": "Milli Savunma Bakanlığı", "priority": 2, "queue": "A1"},
    {"id": 7, "type": "İçişleri Bakanlığı", "priority": 2, "queue": "A2"},
    {"id": 8, "type": "Kritik Görevlerde Çalışan", "priority": 2, "queue": "A3"},
    {"id": 9, "type": "Zabıta, Özel Güvenlik", "priority": 2, "queue": "A4"},
    {"id": 10, "type": "Adalet Bakanlığı", "priority": 2, "queue": "A5"},
    {"id": 11, "type": "Ceza Evleri", "priority": 2, "queue": "A6"},
    {"id": 12, "type": "Eğitim Sektörü", "priority": 2, "queue": "A7"},
    {"id": 13, "type": "Gıda Sektörü", "priority": 2, "queue": "A8"},
    {"id": 14, "type": "Taşımacılık Sektörü", "priority": 2, "queue": "A9"},
    {"id": 15, "type": "Diğer", "priority": 4, "queue": ""}
  ].map((i) => DropdownModel.fromJson(i)));

  List<DropdownModel> ageList = List<DropdownModel>.from([
    {"id": 0, "type": "85 yaş üzeri", "priority": 1, "queue": "C1"},
    {"id": 1, "type": "80-84 yaş arası", "priority": 1, "queue": "C2"},
    {"id": 2, "type": "75-79 yaş arası", "priority": 1, "queue": "C3"},
    {"id": 3, "type": "70-74 yaş arası", "priority": 1, "queue": "C4"},
    {"id": 4, "type": "65-69 yaş arası", "priority": 1, "queue": "C5"},
    {"id": 5, "type": "60-64 yaş arası", "priority": 2, "queue": "B1"},
    {"id": 6, "type": "55-59 yaş arası", "priority": 2, "queue": "B2"},
    {"id": 7, "type": "50-54 yaş arası", "priority": 2, "queue": "B3"},
    {"id": 8, "type": "40-49 yaş arası", "priority": 3, "queue": "B1"},
    {"id": 9, "type": "30-39 yaş arası", "priority": 3, "queue": "B2"},
    {"id": 10, "type": "18-29 yaş arası", "priority": 3, "queue": "B3"},
    {"id": 11, "type": "18 yaş altı", "priority": 4, "queue": ""}
  ].map((i) => DropdownModel.fromJson(i)));

  DropdownModel selectedAge;
  DropdownModel selectedJob;
  bool hasDisease = false;

  DropdownModel calculateResult() {
    DropdownModel result;

    var decision = selectedJob.priority < selectedAge.priority ? selectedJob.priority : selectedAge.priority;

    if (decision == 1) {
      if (selectedJob.priority == 1) {
        result = selectedJob;
      } else {
        result = selectedAge;
      }
    }

    if (decision == 2) {
      if (selectedJob.priority == 2) {
        result = selectedJob;
      } else {
        result = selectedAge;
      }
    }

    if (decision == 3) {
      if (hasDisease) {
        selectedAge.queue = selectedAge.queue.replaceAll("B", "A");
        result = selectedAge;
      } else {
        result = selectedAge;
      }
    }

    if (decision == 4) {
      result = selectedJob;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Aşı Grubu Hesaplama'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)])),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SizedBox(
                    height: 40,
                  ),
                  DropdownButton<DropdownModel>(
                    isDense: true,
                    hint: Text("Meslek Grubu"),
                    value: selectedJob,
                    onChanged: (DropdownModel newValue) {
                      setState(() {
                        selectedJob = newValue;
                      });
                    },
                    items: jobList.map((DropdownModel item) {
                      return DropdownMenuItem<DropdownModel>(
                        value: jobList[item.id],
                        child: Text(
                          item.type,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  DropdownButton<DropdownModel>(
                    isDense: true,
                    hint: Text("Yaş Grubu"),
                    value: selectedAge,
                    onChanged: (DropdownModel newValue) {
                      setState(() {
                        selectedAge = newValue;
                      });
                    },
                    items: ageList.map((DropdownModel item) {
                      return DropdownMenuItem<DropdownModel>(
                        value: ageList[item.id],
                        child: Text(
                          item.type,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CheckboxListTile(
                    value: hasDisease,
                    activeColor: Color(0xff00B8C0),
                    onChanged: (bool value) {
                      setState(() {
                        hasDisease = value;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Kronik hastalığınız var mı?'),
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
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color(0xff18C4B9), Color(0xff02B9C0)]),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text(
                          'Hesapla',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: () {
                          if (selectedJob != null && selectedAge != null) {
                            var result = calculateResult();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  result: result,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Meslek ve yaş boş bırakılmamalıdır!'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                      ),
                    ),
                  ),
                ]),
              ))),
    );
  }
}

class DropdownModel {
  int id;
  String type;
  int priority;
  String queue;

  DropdownModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    type = json['type'];
    priority = json['priority'];
    queue = json['queue'];
  }

  @override
  String toString() => jsonEncode({'id': id, 'type': type, 'priority': priority, 'queue': queue});
}
