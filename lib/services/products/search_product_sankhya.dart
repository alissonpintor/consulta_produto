import 'dart:convert';

import 'package:consulta_produto/model/product_model.dart';
import 'package:consulta_produto/model/user_model.dart';
import 'package:consulta_produto/services/auth/auth_service.dart';
import 'package:consulta_produto/services/request_payload.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SearchProductSankhya with ChangeNotifier {
  final String _baseUrl = 'https://treina.stoky.dev.br/mgecom/service.sbr';
  final String _serviceName = 'ConsultaProdutosSP.consultaProdutos';
  final String _application = 'ConsultaProdutos';
  final String _resourceID = 'br.com.sankhya.com.cons.consultaProdutos';
  final List<ProductModel> _items = [];

  int get productsCount {
    return _items.length;
  }

  List<ProductModel> get items {
    return [..._items];
  }

  Future<void> searchProdutcts(String query) async {
    UserModel? currentUser = AuthService().currentUser;
    Uri url = Uri.parse(
        '$_baseUrl?serviceName=$_serviceName&application=$_application&outputType=json&resourceID=$_resourceID&mgeSession=${currentUser?.sessionId}');

    // print(url);

    http.Response data = await http.post(
      url,
      headers: {'Cookie': 'JSESSIONID=${currentUser?.sessionId}'},
      body: _makeRequestPayload(query),
    );

    var jsonList =
        jsonDecode(data.body)['responseBody']['produtos']['produto'] as List;
    List<ProductModel> products = [];

    for (var item in jsonList) {
      ProductModel product = ProductModel(
        codigo: int.parse(item['CODPROD']['\$']),
        descricao: item['DESCRPROD']['\$'],
        marca: item['Cadastro_MARCA']['\$'],
        valor: double.parse(item['Preço_1']['\$']),
        unidade: item['CODVOL']['\$'],
        agrupamentoMinimo: double.parse(item['AGRUPMIN']['\$']),
        referencia: item['Cadastro_REFERENCIA']['\$'],
      );
      products.add(product);
    }

    _items.clear();
    _items.addAll([...products]);
    notifyListeners();
  }

  String _makeRequestPayload(String query, {String? codigoParceiro}) {
    return jsonEncode(
      {
        "ServiceName": _serviceName,
        "requestBody": {
          "filtros": {
            "criterio": {
              "resourceID": "br.com.sankhya.com.cons.consultaProdutos",
              "CODPARC": {"\$": ""},
              "NUTAB": {"\$": ""},
              "PERCDESC": "0",
              "VALOR": {"\$": query}
            },
            "dadosContextualizados": {
              "CODPARC": (codigoParceiro == null) ? {} : {"\$": "242"}
            },
            "isLiquidacao": {"\$": "false"},
            "isPromocao": {"\$": "false"}
          }
        }
      },
    );
  }
}
