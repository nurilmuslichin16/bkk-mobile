import 'dart:convert';

import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class UbahProfileModel {
  bool status = false;
  String text = '';

  UbahProfileModel({this.status, this.text});

  factory UbahProfileModel.createObject(Map<String, dynamic> object) {
    return UbahProfileModel(
        status: object['status'], text: object['text'] ?? 'empty');
  }

  static Future postUbahProfile(
      String idPelamar,
      String namaLengkap,
      String username,
      String alamat,
      String kewarganegaraan,
      String nohp,
      String email,
      String tanggalLahir,
      String jurusan) async {
    try {
      var uri = Uri.parse('$baseUrl/ubah_profile_post');
      var respone = await http.post(uri, body: {
        "id_pelamar": idPelamar,
        "nama_lengkap": namaLengkap,
        "username": username,
        "alamat": alamat,
        "kewarganegaraan": kewarganegaraan,
        "no_hp": nohp,
        "email": email,
        "tanggal_lahir": tanggalLahir,
        "jurusan": jurusan
      });

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return UbahProfileModel.createObject(jsonObject);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
