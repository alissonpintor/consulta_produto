class OutputProdutoDto {
  int codigo;
  String descricao;
  String marca;
  String unidade;
  double agrupamentoMinimo;
  double valor;
  String? referencia;

  OutputProdutoDto({
    required this.codigo,
    required this.descricao,
    required this.marca,
    required this.unidade,
    required this.agrupamentoMinimo,
    required this.valor,
    this.referencia,
  });
}
