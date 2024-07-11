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
  Future<Produtos> buscarPorCodigo(int codigo) async {
    Uri url = Uri.parse('$baseUrl?serviceName=$serviceName&outputType=json');
    String sessionId = 'asdasdad';
    expression.add('this.CODPROD = ?');
    parameters.add({
      "\$": codigo.toString(),
      "type": "I",
    });

    http.Response data = await http.post(
      url,
      body: _getPayload(),
      headers: {'Cookie': 'JSESSIONID=${sessionId}'},
    );

    var json = jsonDecode(data.body);
    json = json['responseBody']['entities']['entity'] as List;

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

  Future<List<Produtos>?>? buscarPorDescricao(String descricao) async {
    return null;
  }

  Future<List<Produtos>?>? buscarPorMarca(String marca) async {
    return null;
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
