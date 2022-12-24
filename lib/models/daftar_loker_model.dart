import 'dart:convert';

import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class DaftarLokerModel {
  String idDetailLoker = '';
  bool status = false;
  String text = '';

  DaftarLokerModel({this.idDetailLoker, this.status, this.text});

  factory DaftarLokerModel.createObject(Map<String, dynamic> object) {
    return DaftarLokerModel(
        idDetailLoker: object['idDetailLoker'].toString() ?? 'empty',
        status: object['status'],
        text: object['text'] ?? 'empty');
  }

  static Future postDaftar(String idLowongan, String idPelamar) async {
    try {
      var uri = Uri.parse('$baseUrl/daftar_loker_post');
      var respone = await http.post(uri,
          body: {"id_lowongan": idLowongan, "id_pelamar": idPelamar});

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return DaftarLokerModel.createObject(jsonObject);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
