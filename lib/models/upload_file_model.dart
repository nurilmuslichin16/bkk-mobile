import 'dart:convert';

import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class UbahPassModel {
  bool status = false;
  String text = '';

  UbahPassModel({this.status, this.text});

  factory UbahPassModel.createObject(Map<String, dynamic> object) {
    return UbahPassModel(
      status: object['status'],
      text: object['text'] ?? 'empty',
    );
  }

  static Future postUbahPassword(
      String username, String passLama, String passBaru) async {
    try {
      var uri = Uri.parse('$baseUrl/ubah_password_post');
      var respone = await http.post(uri, body: {
        "username": username,
        "passwordLama": passLama,
        "passwordBaru": passBaru,
      });

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return UbahPassModel.createObject(jsonObject);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
