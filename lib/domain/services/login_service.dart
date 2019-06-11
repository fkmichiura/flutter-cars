import 'dart:convert';

import 'package:carros_app/domain/response.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Response> login(String login, String pass) async {
    var url = "http://livrowebservices.com.br/rest/login";

    final response =
        await http.post(url, body: {'login': login, 'senha': pass});

    final Map<String, dynamic> map = json.decode(response.body);

    return Response.fromJson(map);
  }
}
