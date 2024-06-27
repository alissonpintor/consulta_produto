import 'dart:convert';

enum Type { string, integer, date, datetime, decimal }

Map<Type, String> dataType = {
  Type.string: 'S', // decimal separado por '.'
  Type.integer: 'I',
  Type.decimal: 'F',
  Type.date: 'D', // formato: DD/MM/AAAA
  Type.datetime: 'H' // formato: DD/MM/AAAA HH:MM:SS
};

class RequestPayload {
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

  void addFilterCodigo(int codigo) {
    expression.add('this.CODPROD = ?');
    parameters.add({
      "\$": codigo.toString(),
      "type": dataType[Type.integer],
    });
  }

  void addFilterDescricao(String descricao) {
    expression.add('this.DESCRPROD like ?');
    parameters.add({
      "\$": descricao,
      "type": dataType[Type.string],
    });
  }

  void addFilterMarca(String marca) {
    expression.add('this.MARCA like ?');
    parameters.add({
      "\$": marca,
      "type": dataType[Type.string],
    });
  }

  dynamic getJsonEncode() {
    return jsonEncode(
      {
        "serviceName": serviceName,
        "requestBody": {
          "dataSet": {
            "rootEntity": rootEntity,
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
