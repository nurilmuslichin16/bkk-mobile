import 'dart:convert';

import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class LokerModel {
  String idLoker;
  String namaPerusahaan;
  String tanggalAwal;
  String tanggalAkhir;
  String posisi;
  String foto;

  LokerModel({
    this.idLoker,
    this.namaPerusahaan,
    this.tanggalAwal,
    this.tanggalAkhir,
    this.posisi,
    this.foto,
  });

  factory LokerModel.createObject(Map<String, dynamic> object) {
    return LokerModel(
      idLoker: object['id_lowongan'] ?? 'empty',
      namaPerusahaan: object['nama_perusahaan'] ?? 'empty',
      tanggalAwal: object['tanggal_mulai'] ?? 'empty',
      tanggalAkhir: object['tanggal_akhir'] ?? 'empty',
      posisi: object['posisi'] ?? 'empty',
      foto: object['foto'] ?? 'empty',
    );
  }

  static Future<List<LokerModel>> getListLoker() async {
    try {
      var uri = Uri.parse('$baseUrl/new_loker');
      var respone = await http.get(uri);

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);
        List<dynamic> listLoker = (jsonObject as Map<String, dynamic>)['data'];

        List<LokerModel> loker = [];
        for (var i = 0; i < listLoker.length; i++) {
          loker.add(LokerModel.createObject(listLoker[i]));
        }

        return loker;
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
