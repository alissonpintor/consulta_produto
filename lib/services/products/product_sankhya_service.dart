import 'dart:convert';

import 'package:consulta_produto/data/product_list_data.dart';
import 'package:consulta_produto/model/product_model.dart';
import 'package:consulta_produto/model/user_model.dart';
import 'package:consulta_produto/services/auth/auth_service.dart';
import 'package:consulta_produto/services/products/product_service.dart';
import 'package:consulta_produto/services/request_payload.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductSankhyaService with ChangeNotifier implements ProductService {
  final String baseUrl = 'https://treina.stoky.dev.br/mge/service.sbr';
  final String serviceName = 'CRUDServiceProvider.loadRecords';
  final List<ProductModel> _products = [];
  int _paginationCount = 0;

  ProductSankhyaService() {
    loadProducts();
  }

  @override
  List<ProductModel> get items => [..._products];
  int get productsCount => _products.length;

  Future<void> loadProducts() async {
    UserModel? currentUser = AuthService().currentUser;
    Uri url = Uri.parse('$baseUrl?serviceName=$serviceName&outputType=json');
    var payload = RequestPayload();
    payload.addFilterDescricao('JOEL%SOLD%25MM%');

    http.Response data = await http.post(
      url,
      body: payload.getJsonEncode(),
      headers: {'Cookie': 'JSESSIONID=${currentUser?.sessionId}'},
    );

    var jsonList =
        jsonDecode(data.body)['responseBody']['entities']['entity'] as List;
    List<ProductModel> products = [];

    jsonList.forEach((item) {
      //item = item['_rmd'];

      ProductModel product = ProductModel(
          codigo: int.parse(item['f0']['\$']),
          descricao: item['f1']['\$'],
          marca: item['f2']['\$'],
          valor: 59.99,
          unidade: item['f3']['\$'],
          agrupamentoMinimo: 1,
          referencia: item['f4']['\$']);

      products.add(product);
    });

    _products.clear();
    _products.addAll([...products]);
    notifyListeners();
  }

  @override
  Future<void> searchProdutcts(String query,
      {bool isPagination = false}) async {
    UserModel? currentUser = AuthService().currentUser;
    Uri url = Uri.parse('$baseUrl?serviceName=$serviceName&outputType=json');

    _paginationCount = isPagination ? _paginationCount : 0;

    // if (currentUser == null) {
    //   await AuthService().login('alisson', 'studiowork');
    //   currentUser = AuthService().currentUser;
    // }

    http.Response data = await http.post(
      url,
      body: jsonEncode(
        {
          "requestBody": {
            "dataSet": {
              "rootEntity": "Produto",
              "includePresentationFields": "N",
              "offsetPage": "$_paginationCount",
              "criteria": {
                "expression": {"\$": "this.MARCA like ?"},
                "parameter": [
                  {"\$": query.toUpperCase(), "type": "S"}
                ]
              },
              "entity": {
                "fieldset": {
                  "list": "CODPROD,DESCRPROD,MARCA,CODVOL,REFERENCIA"
                }
              }
            }
          }
        },
      ),
      headers: {'Cookie': 'JSESSIONID=${currentUser?.sessionId}'},
    );

    var jsonList =
        jsonDecode(data.body)['responseBody']['entities']['entity'] as List;
    List<ProductModel> products = [];

    var metadata = jsonDecode(data.body);
    var hasMoreResult = metadata['responseBody']['entities']['hasMoreResult'];
    if (hasMoreResult == 'true') {
      _paginationCount =
          int.parse(metadata['responseBody']['entities']['offsetPage']) + 1;
    }

    print(_paginationCount);

    for (var item in jsonList) {
      ProductModel product = ProductModel(
        codigo: int.parse(item['f0']['\$']),
        descricao: item['f1']['\$'],
        marca: item['f2']['\$'],
        valor: 59.99,
        unidade: item['f3']['\$'],
        agrupamentoMinimo: 1,
        referencia: item['f4']['\$'],
      );
      products.add(product);
    }

    _products.clear();
    _products.addAll([...products]);
    notifyListeners();
  }
}
