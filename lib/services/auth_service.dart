import 'dart:convert';

import 'package:bkkmobile/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'http://localhost/bkkweb/api';

  Future<UserModel> register({
    String nama,
    String username,
    String password,
  }) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          true, // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    var body = jsonEncode({
      'nama': nama,
      'username': username,
      'password': password,
    });

    var respons = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(respons.body);

    if (respons.statusCode == 200) {
      var data = jsonDecode(respons.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);

      return user;
    } else {
      throw Exception('Gagal register');
    }
  }

  Future<UserModel> login({
    String username,
    String password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-type': 'application/json'};
    var body = jsonEncode({
      'username': username,
      'password': password,
    });

    var respons = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(respons.body);

    if (respons.statusCode == 200) {
      var data = jsonDecode(respons.body)['data'];
      UserModel user = UserModel.fromJson(data);

      return user;
    } else {
      throw Exception('Gagal login');
    }
  }
}
