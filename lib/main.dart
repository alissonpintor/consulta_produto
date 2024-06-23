import 'dart:convert';

import 'package:consulta_produto/pages/home_page.dart';
import 'package:consulta_produto/routes.dart';
import 'package:consulta_produto/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    minimumSize: Size(1280, 720),
    maximumSize: Size(1920, 1080),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _httpClient = http.Client();

  Future<void> login() async {
    String baseUrl = 'https://treina.stoky.dev.br/mge/service.sbr';
    String serviceName = 'MobileLoginSP.login';
    Uri loginUrl =
        Uri.parse('$baseUrl?serviceName=$serviceName&outputType=json');

    http.Response data = await _httpClient.post(
      loginUrl,
      body: jsonEncode({
        "serviceName": "MobileLoginSP.login",
        "requestBody": {
          "NOMUSU": {"\$": "LUCAS"},
          "INTERNO": {"\$": "15975348655"},
          "KEEPCONNECTED": {"\$": "S"}
        }
      }),
    );

    String sessionId =
        jsonDecode(data.body)['responseBody']['jsessionid']['\$'];

    _getProduto(sessionId);
  }

  Future<void> _getProduto(sessionId) async {
    String baseUrl = 'https://treina.stoky.dev.br/mge/service.sbr';
    String serviceName = 'CRUDServiceProvider.loadRecords';
    Uri url = Uri.parse(
        '$baseUrl?serviceName=$serviceName&outputType=json&mgeSession=$sessionId');

    print(url);

    http.Response data = await _httpClient.post(
      url,
      body: jsonEncode(
        {
          "requestBody": {
            "dataSet": {
              "rootEntity": "Produto",
              "includePresentationFields": "N",
              "offsetPage": "0",
              "criteria": {
                "expression": {"\$": "this.MARCA like ?"},
                "parameter": [
                  {"\$": "KRON%", "type": "S"}
                ]
              },
              "entity": {
                "fieldset": {"list": "CODPROD,DESCRPROD,LOCAL,MARCA,CODVOL"}
              }
            }
          }
        },
      ),
      headers: {'Cookie': 'JSESSIONID=$sessionId'},
    );

    //print(data.headers);
    print(jsonDecode(data.body) as Map);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
      ),
      routes: {
        AppRoutes.home: (ctx) => const HomePage(),
      },
    );
  }
}
