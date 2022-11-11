import 'dart:convert';
import 'package:bkkmobile/models/loker_model.dart';
import 'package:http/http.dart' as http;

class LokerService {
  String baseUrl = 'http://localhost/bkkweb/api';

  Future<List<LokerModel>> getLokers() async {
    var url = '$baseUrl/Loker';
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
        lokers.add(LokerModel.fromJson(item));
      }

      return lokers;
    } else {
      throw Exception('Gagal menampilkan data loker!');
    }
  }
}
