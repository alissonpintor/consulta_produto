import 'package:consulta_produto/core/produtos/dto/output_produto_dto.dart';
import 'package:consulta_produto/core/produtos/models/produtos.dart';
import 'package:consulta_produto/core/produtos/repository/produto_repository.dart';

class ConsultarPorMarcaService {
  Produtos? produto;

  Future<List<OutputProdutoDto?>> execute(
    String marca,
    ProdutoRepository repository,
  ) async {
    List<OutputProdutoDto> produtosDto = [];
    var produtos = await repository.buscarPorMarca(marca);

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
