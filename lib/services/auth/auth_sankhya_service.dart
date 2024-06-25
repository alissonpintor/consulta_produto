import 'dart:convert';

import 'package:consulta_produto/model/user_model.dart';
import 'package:consulta_produto/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthSankhyaService with ChangeNotifier implements AuthService {
  final _httpClient = http.Client();
  final String serviceMame = 'MobileLoginSP.login';

  UserModel? _user;
  String? _sessionId;

  @override
  // TODO: implement currentUser
  UserModel? get currentUser => _user;

  @override
  Future<void> login(String username, String password) async {
    String baseUrl = 'https://treina.stoky.dev.br/mge/service.sbr';
    String serviceName = 'MobileLoginSP.login';
    Uri loginUrl =
        Uri.parse('$baseUrl?serviceName=$serviceName&outputType=json');

    http.Response response = await _httpClient.post(
      loginUrl,
      body: jsonEncode({
        "serviceName": "MobileLoginSP.login",
        "requestBody": {
          "NOMUSU": {"\$": username},
          "INTERNO": {"\$": password},
          "KEEPCONNECTED": {"\$": "S"}
        }
      }),
    );

    var data = jsonDecode(response.body) as Map;
    String sessionId = data['responseBody']['jsessionid']['\$'];

    _user = UserModel(username: username, password: password);
    if (sessionId.isNotEmpty) {
      _user!.setSessionId(sessionId);
    }
  }

  @override
  Future<void> logout() async {
    _user = null;
  }
}
