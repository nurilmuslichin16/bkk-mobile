import 'dart:convert';

import 'package:bkkmobile/shared/variabel.dart';
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
  String nisn = '';
  String jurusan = '';
  String jenis = '';

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
      this.nisn,
      this.jurusan,
      this.jenis});

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
      nisn: object['nisn'] ?? 'empty',
      jurusan: object['jurusan'] ?? 'empty',
      jenis: object['jenis'] ?? 'empty',
    );
  }

  static Future postLogin(String nisn, String pass) async {
    try {
      var uri = Uri.parse('$baseUrl/login_post');
      var respone = await http.post(uri, body: {
        "nisn": nisn,
        "password": pass,
      });

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return LoginModel.createObject(jsonObject);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
