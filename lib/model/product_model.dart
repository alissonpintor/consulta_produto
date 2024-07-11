class ProductModel {
  int codigo;
  String descricao;
  String marca;
  String unidade;
  double agrupamentoMinimo;
  double valor;
  String? referencia;
  String? codigoFornecedor;
  double? valorPromocao;
  bool? estaEmPromocao;
  bool? novidade;
  bool? chegouNoEstoque;

  ProductModel(
      {required this.codigo,
      required this.descricao,
      required this.marca,
      required this.valor,
      required this.unidade,
      required this.agrupamentoMinimo,
      this.referencia,
      this.codigoFornecedor,
      this.valorPromocao,
      this.estaEmPromocao = false,
      this.novidade = false,
      this.chegouNoEstoque = false});

  factory ProductModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductModel(
      codigo: int.parse(json['f0']['\$']),
      descricao: json['f1']['\$'],
      marca: json['f2']['\$'],
      valor: 59.99,
      unidade: json['f3']['\$'],
      agrupamentoMinimo: 1,
      referencia: json['f4']['\$'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    throw UnimplementedError;
  }
}
