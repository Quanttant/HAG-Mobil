import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hag/pages/result_page.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';

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

  int selectedJobIndex = 0;
  int selectedAgeIndex = 0;

  bool hasDisease = false;

  DropdownModel calculateResult() {
    DropdownModel result;
    DropdownModel selectedJob = jobList[selectedJobIndex];
    DropdownModel selectedAge = ageList[selectedAgeIndex];

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
      body: DirectSelectContainer(
        child: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SizedBox(
                      height: 40,
                    ),
                    getDropdown(data: jobList, label: "Meslek Grubu", selectedIndex: selectedJobIndex, type: 0),
                    SizedBox(
                      height: 40,
                    ),
                    getDropdown(data: ageList, label: "Yaş Grubu", selectedIndex: selectedAgeIndex, type: 1),
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
                            if (jobList[selectedJobIndex] != null && ageList[selectedAgeIndex] != null) {
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
      ),
    );
  }

  Widget getDropdown({List<DropdownModel> data, String label, int selectedIndex, int type}) {
    return Column(
      children: [
        Container(alignment: AlignmentDirectional.centerStart, margin: EdgeInsets.only(left: 4), child: Text(label)),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Container(
            decoration: _getShadowDecoration(),
            child: Card(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        child: DirectSelectList<DropdownModel>(
                          values: data,
                          defaultItemIndex: selectedIndex,
                          itemBuilder: (DropdownModel value) => getDropDownMenuItem(data, value),
                          onUserTappedListener: () {
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Seçmek için basılı tutun'),
                              backgroundColor: Color(0xff00B8C0),
                            ));
                          },
                          onItemSelectedListener: (item, index, context) {
                            setState(() {
                              selectedIndex = index;
                              if (type == 0)
                                selectedJobIndex = selectedIndex;
                              else
                                selectedAgeIndex = selectedIndex;
                            });
                          },
                          focusedItemDecoration: _getDslDecoration(),
                        ),
                        padding: EdgeInsets.only(left: 12))),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: _getDropdownIcon(),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  DirectSelectItem<DropdownModel> getDropDownMenuItem(List<DropdownModel> data, DropdownModel item) {
    return DirectSelectItem<DropdownModel>(
        itemHeight: 56,
        value: data[item.id],
        itemBuilder: (context, value) {
          return Text(
            item.type,
            style: TextStyle(color: Color(0xff00B8C0), fontWeight: FontWeight.bold),
          );
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Color(0xff00B8C0)),
        top: BorderSide(width: 1, color: Color(0xff00B8C0)),
      ),
    );
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Color(0xff00B8C0),
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(0.0, 0.0),
          blurRadius: 15.0,
        ),
      ],
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
