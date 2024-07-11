import 'package:consulta_produto/core/produtos/dto/output_produto_dto.dart';
import 'package:consulta_produto/core/produtos/models/produtos.dart';
import 'package:consulta_produto/core/produtos/repository/produto_repository.dart';

class ConsultarPorDescricaoService {
  Produtos? produto;

  Future<List<OutputProdutoDto?>> execute(
    String descricao,
    ProdutoRepository repository,
  ) async {
    List<OutputProdutoDto> produtosDto = [];
    var produtos = await repository.buscarPorDescricao(descricao);

    if (produtos == null || produtos.isEmpty) {
      return [];
    }

    for (produto in produtos) {
      var produtoDto = OutputProdutoDto(
        codigo: produto!.codigo,
        descricao: produto!.descricao,
        marca: produto!.marca,
        unidade: produto!.marca,
        agrupamentoMinimo: produto!.agrupamentoMinimo,
        valor: produto!.valor,
      );

      produtosDto.add(produtoDto);
    }

    return produtosDto;
  }
}
