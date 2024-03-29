import 'dart:convert';

import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class RegisterModel {
  bool status = false;
  String text = '';

  RegisterModel({this.status, this.text});

  factory RegisterModel.createObject(Map<String, dynamic> object) {
    return RegisterModel(
        status: object['status'], text: object['text'] ?? 'empty');
  }

  static Future postLogin(
      String namaLengkap,
      String username,
      String password,
      String alamat,
      String nisn,
      String nohp,
      String email,
      String tanggalLahir,
      String jurusan,
      String jenis) async {
    try {
      var uri = Uri.parse('$baseUrl/register_post');
      var respone = await http.post(uri, body: {
        "nama_lengkap": namaLengkap,
        "username": username,
        "password": password,
        "alamat": alamat,
        "nisn": nisn,
        "no_hp": nohp,
        "email": email,
        "tanggal_lahir": tanggalLahir,
        "jurusan": jurusan,
        "jenis": jenis
      });

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return RegisterModel.createObject(jsonObject);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
