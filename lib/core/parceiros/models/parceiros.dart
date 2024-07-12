class Parceiros {
  int codigo;
  String nome;
  String? razao;
  String? tipoPessoa;
  String? ativo;
  String? cnpj;

  Parceiros({
    required this.codigo,
    required this.nome,
    this.razao,
    this.cnpj,
    this.ativo,
    this.tipoPessoa,
  });
}
