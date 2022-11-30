import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginModel {
  bool status = false;
  String text = '';
  String idPelamar = '';
  String namaLengkap = '';
  String username = '';
  String alamat = '';
  String nohp = '';
  String email = '';
  String tanggalLahir = '';
  String kewarganegaraan = '';
  String jurusan = '';

  LoginModel(
      {this.status,
      this.text,
      this.idPelamar,
      this.namaLengkap,
      this.username,
      this.alamat,
      this.nohp,
      this.email,
      this.tanggalLahir,
      this.kewarganegaraan,
      this.jurusan});

  factory LoginModel.createObject(Map<String, dynamic> object) {
    return LoginModel(
      status: object['status'],
      text: object['text'] ?? 'empty',
      idPelamar: object['id_pelamar'] ?? 'empty',
      namaLengkap: object['nama_lengkap'] ?? 'empty',
      username: object['username'] ?? 'empty',
      alamat: object['alamat'] ?? 'empty',
      nohp: object['no_hp'] ?? 'empty',
      email: object['email'] ?? 'empty',
      tanggalLahir: object['tanggal_lahir'] ?? 'empty',
      kewarganegaraan: object['kewarganegaraan'] ?? 'empty',
      jurusan: object['jurusan'] ?? 'empty',
    );
  }

  static Future postLogin(String username, String pass) async {
    try {
      var uri = Uri.parse('http://192.168.100.17/bkk-smk/api/login_post');
      var respone = await http.post(uri, body: {
        "username": username,
        "password": pass,
      });

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return LoginModel.createObject(jsonObject);
      } else {
        print("Can't Connect Server");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
