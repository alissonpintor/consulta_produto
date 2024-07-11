import 'package:consulta_produto/model/product_model.dart';

abstract class ProductService {
  List<ProductModel> get items;
  Future<void> searchProdutcts(String query);
}
