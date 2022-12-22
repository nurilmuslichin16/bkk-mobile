import 'dart:convert';
import 'package:bkkmobile/models/cek_loker_model.dart';
import 'package:bkkmobile/models/detail_loker_model.dart';
import 'package:bkkmobile/models/loker_model.dart';
import 'package:bkkmobile/shared/variabel.dart';
import 'package:http/http.dart' as http;

class LokerService {
  String baseUrlOld = 'http://localhost/bkkweb/api';

  Future<List<LokerModel>> getLokers() async {
    var url = Uri.parse('$baseUrlOld/Loker');
    var headers = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          true, // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "GET, OPTIONS"
    };

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<LokerModel> lokers = [];

      for (var item in data) {
        lokers.add(LokerModel.createObject(item));
      }

      return lokers;
    } else {
      throw Exception('Gagal menampilkan data loker!');
    }
  }

  Future<DetailLokerModel> getDetailLoker(String idLoker) async {
    try {
      var uri = Uri.parse('$baseUrl/detail_loker/$idLoker');
      var respone = await http.get(uri);

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return DetailLokerModel.createObject(jsonObject['data']);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  Future<CekLokerModel> getStatusLoker(
      String idLowongan, String idPelamar) async {
    try {
      var uri = Uri.parse('$baseUrl/cek_status_loker/$idLowongan/$idPelamar');
      var respone = await http.get(uri);

      if (respone.statusCode == 200) {
        var jsonObject = jsonDecode(respone.body);

        return CekLokerModel.createObject(jsonObject);
      } else {
        print("Error : Can't Connect Server");
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
