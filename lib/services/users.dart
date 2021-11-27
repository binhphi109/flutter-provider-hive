import 'dart:convert';

import 'package:flutter_sample/helpers/config.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<http.Response> login(email, password) {
    return http.post(
      Uri.parse('${Config.ApiUrl}/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }

  static Future<http.Response> register(email, name, password) {
    return http.post(
      Uri.parse('${Config.ApiUrl}/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'password': password,
      }),
    );
  }
}
