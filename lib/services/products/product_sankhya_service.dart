import 'package:consulta_produto/model/product_model.dart';
import 'package:consulta_produto/services/products/product_service.dart';
import 'package:flutter/material.dart';

class ProductSankhyaService with ChangeNotifier implements ProductService {
  final String serviceName = 'CRUDServiceProvider.loadRecords';

  @override
  // TODO: implement products
  List<ProductModel> get products => throw UnimplementedError();

  @override
  List<ProductModel> searchProdutcts(String query) {
    // TODO: implement searchProdutcts
    throw UnimplementedError();
  }
}
