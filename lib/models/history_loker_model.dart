import 'dart:convert';

import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class HistoryLokerModel {
  String idLoker;
  String namaPerusahaan;
  String tanggalLamar;
  String posisi;
  String status;
  String foto;

  HistoryLokerModel({
    this.idLoker,
    this.namaPerusahaan,
    this.tanggalLamar,
    this.posisi,
    this.status,
    this.foto,
  });

  factory HistoryLokerModel.createObject(Map<String, dynamic> object) {
    return HistoryLokerModel(
      idLoker: object['id_lowongan'] ?? 'empty',
      namaPerusahaan: object['nama_perusahaan'] ?? 'empty',
      tanggalLamar: object['tanggal_lamar'] ?? 'empty',
      posisi: object['posisi'] ?? 'empty',
      status: object['status'] ?? 'empty',
      foto: object['foto'] ?? 'empty',
    );
  }

  static Future<List<HistoryLokerModel>> getHistoryListLoker() async {
    try {
      var uri = Uri.parse('$baseUrl/history_loker/$idPelamarUser');
      var respone = await http.get(uri);

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);
        List<dynamic> listLoker = (jsonObject as Map<String, dynamic>)['data'];

        List<HistoryLokerModel> loker = [];
        for (var i = 0; i < listLoker.length; i++) {
          loker.add(HistoryLokerModel.createObject(listLoker[i]));
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
