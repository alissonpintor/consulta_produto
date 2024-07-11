import 'package:consulta_produto/core/produtos/dto/output_produto_dto.dart';
import 'package:consulta_produto/core/produtos/models/produtos.dart';
import 'package:consulta_produto/core/produtos/repository/produto_repository.dart';

class ConsultarPorCodigoService {
  Produtos? produto;

  Future<OutputProdutoDto?> execute(
    int codigo,
    ProdutoRepository repository,
  ) async {
    var produto = await repository.buscarPorCodigo(codigo);

    if (produto == null) {
      return null;
    }

    var produtoDto = OutputProdutoDto(
      codigo: codigo,
      descricao: produto.descricao,
      marca: produto.marca,
      unidade: produto.marca,
      agrupamentoMinimo: produto.agrupamentoMinimo,
      valor: produto.valor,
    );

    return produtoDto;
  }
}
