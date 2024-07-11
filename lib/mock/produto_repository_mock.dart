import 'package:consulta_produto/core/produtos/models/produtos.dart';
import 'package:consulta_produto/core/produtos/repository/produto_repository.dart';
import 'package:consulta_produto/data/product_list_data.dart';

class ProdutoRepositoryMock implements ProdutoRepository {
  @override
  Future<Produtos> buscarPorCodigo(int codigo) async {
    var produto = ProductListData.products.firstWhere((produto) {
      return produto.codigo == codigo;
    });
    return produto;
  }

  Future<List<Produtos>> buscarPorDescricao(String descricao) async {
    List<Produtos> produtos = [];
    descricao = descricao.toLowerCase();

    for (Produtos produto in ProductListData.products) {
      var descricaoProduto = produto.descricao.toLowerCase();

      if (descricaoProduto.contains(descricao)) produtos.add(produto);
    }

    return produtos;
  }

  Future<List<Produtos>> buscarPorMarca(String marca) async {
    List<Produtos> produtos = [];
    marca = marca.toLowerCase();

    for (Produtos produto in ProductListData.products) {
      var marcaProduto = produto.marca.toLowerCase();

      if (marcaProduto.contains(marca)) produtos.add(produto);
    }

    return produtos;
  }
}
