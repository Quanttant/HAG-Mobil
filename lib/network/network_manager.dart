import 'dart:convert';

import 'package:hag/network/vaccine_response.dart';
import 'package:hag/utils/app_constant.dart';
import 'package:http/http.dart' as http;

class NetworkManager {

  static Future<dynamic> getVaccineStats() async {
    try {
      final response = await http.get(AppConstant.dataUrl);
      if (response.statusCode == 200) {
        return VaccineReponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
