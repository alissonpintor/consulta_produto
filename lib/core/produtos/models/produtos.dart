class Produtos {
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

  Produtos({
    required this.codigo,
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
    this.chegouNoEstoque = false,
  });
}
