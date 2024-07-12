import 'dart:convert';
import 'package:consulta_produto/core/produtos/models/produtos.dart';
import 'package:consulta_produto/core/produtos/repository/produto_repository.dart';
import 'package:http/http.dart' as http;

class ProdutoRepositorySankhya implements ProdutoRepository {
  final String baseUrl = 'https://treina.stoky.dev.br/mge/service.sbr';
  final String serviceName = 'CRUDServiceProvider.loadRecords';
  String rootEntity = 'Produto';
  List<String> expression = [];
  List<Map<String, dynamic>> parameters = [];
  List<String> fieldSet = [
    'CODPROD',
    'DESCRPROD',
    'MARCA',
    'CODVOL',
    'REFERENCIA'
  ];

  @override
  Future<Produtos?> buscarPorCodigo(int codigo) async {
    expression.clear();
    parameters.clear();

    expression.add('this.CODPROD = ?');
    parameters.add({
      "\$": codigo.toString(),
      "type": "I",
    });

    var json = await _makeRequest();

    if (json == null) return null;

    var produto = Produtos(
      codigo: int.parse(json['f0']['\$']),
      descricao: json['f1']['\$'],
      marca: json['f2']['\$'],
      valor: 59.99,
      unidade: json['f3']['\$'],
      agrupamentoMinimo: 1,
      referencia: json['f4']['\$'],
    );

    return produto;
  }

  @override
  Future<List<Produtos>?>? buscarPorDescricao(String descricao) async {
    expression.clear();
    parameters.clear();

    expression.add("this.DESCRPROD like '?%'");
    parameters.add({
      "\$": descricao.toUpperCase(),
      "type": "S",
    });

    var json = await _makeRequest();
    if (json == null) return [];
    return _getListaProdutos(json);
  }

  Future<List<Produtos>?>? buscarPorMarca(String marca) async {
    expression.clear();
    parameters.clear();

    expression.add("this.MARCA like '?%'");
    parameters.add({
      "\$": marca.toUpperCase(),
      "type": "S",
    });

    var json = await _makeRequest();
    return _getListaProdutos(json);
  }

  dynamic _makeRequest() async {
    Uri url = Uri.parse('$baseUrl?serviceName=$serviceName&outputType=json');
    String sessionId = 'a3UqdnBbucyGE_HsnFvYgtjmowwlT4NSD4RJbI2D';

    http.Response data = await http.post(
      url,
      body: _getPayload(),
      headers: {'Cookie': 'JSESSIONID=${sessionId}'},
    );

    var json = jsonDecode(data.body) as Map<dynamic, dynamic>;
    json = json['responseBody']['entities'];

    if (!json.containsKey('entity')) return null;

    var produtos = json['entity'];
    if (produtos is List) {
      produtos = produtos as List;
    }

    return produtos;
  }

  List<Produtos> _getListaProdutos(dynamic json) {
    List<Produtos> produtos = [];

    for (dynamic item in json) {
      var produto = Produtos(
        codigo: int.parse(item['f0']['\$']),
        descricao: item['f1']['\$'],
        marca: item['f2']['\$'] ?? '',
        valor: 59.99,
        unidade: item['f3']['\$'],
        agrupamentoMinimo: 1,
        referencia: item['f4']['\$'],
      );

      produtos.add(produto);
    }

    return produtos;
  }

  dynamic _getPayload() {
    return jsonEncode(
      {
        "serviceName": serviceName,
        "requestBody": {
          "dataSet": {
            "rootEntity": "Produto",
            "includePresentationFields": "N",
            "offsetPage": "0",
            "criteria": {
              "expression": {"\$": expression.join(' ')},
              "parameter": parameters
            },
            "entity": {
              "fieldset": {"list": fieldSet.join(',')}
            }
          }
        }
      },
    );
  }
}
