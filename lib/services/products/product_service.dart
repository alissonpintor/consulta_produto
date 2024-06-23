import 'package:consulta_produto/model/product_model.dart';
import 'package:consulta_produto/services/products/product_sankhya_service.dart';

abstract class ProductService {
  List<ProductModel> get products;
  List<ProductModel> searchProdutcts(String query);

  factory ProductService() {
    return ProductSankhyaService();
  }
}
