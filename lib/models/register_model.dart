import 'dart:convert';

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
      String kewarganegaraan,
      String nohp,
      String email,
      String tanggalLahir,
      String jurusan) async {
    try {
      var uri = Uri.parse('http://192.168.100.17:80/bkk-smk/api/register_post');
      var respone = await http.post(uri, body: {
        "nama_lengkap": namaLengkap,
        "username": username,
        "password": password,
        "alamat": alamat,
        "kewarganegaraan": kewarganegaraan,
        "nohp": nohp,
        "email": email,
        "tanggalLahir": tanggalLahir,
        "jurusan": jurusan
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
