import 'package:consulta_produto/core/produtos/models/produtos.dart';

interface class ProdutoRepository {
  Future<Produtos?>? buscarPorCodigo(int codigo) async {
    return null;
  }

  Future<List<Produtos>?>? buscarPorDescricao(String descricao) async {
    return null;
  }

  Future<List<Produtos>?>? buscarPorMarca(String marca) async {
    return null;
  }
}
