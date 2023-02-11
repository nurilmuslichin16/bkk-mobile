import 'dart:convert';

import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class BerkasModel {
  bool status;
  String suratLamaran;
  String daftarRiwayat;
  String foto;
  String ktp;
  String skck;
  String ijazah;
  String sertifikat;

  BerkasModel(
      {this.status,
      this.suratLamaran,
      this.daftarRiwayat,
      this.foto,
      this.ktp,
      this.skck,
      this.ijazah,
      this.sertifikat});

  factory BerkasModel.createObject(Map<String, dynamic> object) {
    return BerkasModel(
        status: object['status'] ?? false,
        suratLamaran: object['suratLamaran'] ?? 'empty',
        daftarRiwayat: object['daftarRiwayat'] ?? 'empty',
        foto: object['foto'] ?? 'empty',
        ktp: object['ktp'] ?? 'empty',
        skck: object['skck'] ?? 'empty',
        ijazah: object['ijazah'] ?? 'empty',
        sertifikat: object['sertifikat'] ?? 'empty');
  }

  static Future<BerkasModel> getBerkas() async {
    try {
      var uri = Uri.parse('$baseUrl/cek_berkas/$nisnUser');
      var respone = await http.get(uri);

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return BerkasModel.createObject(jsonObject);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
