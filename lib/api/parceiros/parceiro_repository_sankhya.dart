import 'dart:convert';
import 'package:consulta_produto/core/parceiros/models/parceiros.dart';
import 'package:consulta_produto/core/parceiros/repository/parceiro_repository.dart';
import 'package:http/http.dart' as http;

class ParceiroRepositorySankhya implements ParceiroRepository {
  final String baseUrl = 'https://treina.stoky.dev.br/mge/service.sbr';
  final String serviceName = 'PesquisaSP.getSuggestion';
  String rootEntity = 'Parceiro';
  List<String> expression = [];
  List<Map<String, dynamic>> parameters = [];

  @override
  Future<Parceiros?> buscarPorCnpj(String cnpj) async {
    // TODO: implement buscarPorCnpj
    throw UnimplementedError();
  }

  @override
  Future<Parceiros?> buscarPorCodigo(int codigo) async {
    // TODO: implement buscarPorCodigo
    throw UnimplementedError();
  }

  @override
  Future<List<Parceiros?>> buscarPorNome(String nome) async {
    expression.clear();
    parameters.clear();

    expression.add("this.MARCA like '?%'");
    parameters.add({"\$": nome});

    var json = await _makeRequest();
    return _getListaParceiros(json);
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
    json = jsonDecode(json['responseBody']['json']['\$']);

    if (!json.containsKey('data')) return null;

    var parceiros = json['data'];
    if (parceiros is List) {
      parceiros = parceiros as List;
    }

    return parceiros;
  }

  List<Parceiros> _getListaParceiros(dynamic json) {
    List<Parceiros> parceiros = [];

    for (dynamic item in json) {
      var parceiro = Parceiros(
          codigo: item['CODPARC'],
          nome: item['NOMEPARC'],
          razao: item['RAZAOSOCIAL'],
          cnpj: item['CGC_CPF'],
          ativo: item['ATIVO'],
          tipoPessoa: item['TIPPESSOA']);

      parceiros.add(parceiro);
    }

    return parceiros;
  }

  dynamic _getPayload() {
    return jsonEncode({
      "serviceName": serviceName,
      "requestBody": {
        "criteria": {
          "entityName": rootEntity,
          "compacted": false,
          "ignoreEntityCriteria": false,
          "limit": 5,
          "query": parameters,
          "orderByDesc": false,
          "options": {}
        }
      }
    });
  }
}
