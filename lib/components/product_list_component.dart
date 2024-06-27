import 'package:consulta_produto/components/badge_component.dart';
import 'package:consulta_produto/components/card_component.dart';
import 'package:consulta_produto/components/side_menu_component.dart';
import 'package:consulta_produto/model/product_model.dart';
import 'package:consulta_produto/services/products/product_sankhya_service.dart';
import 'package:consulta_produto/services/products/search_product_sankhya.dart';
import 'package:consulta_produto/utils/consts.dart';
import 'package:consulta_produto/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:consulta_produto/data/product_list_data.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class ProductListComponent extends StatefulWidget {
  ProductListComponent({super.key});

  @override
  State<ProductListComponent> createState() => _ProductListComponentState();
}

class _ProductListComponentState extends State<ProductListComponent> {
  int? _selectedItem;

  Widget _getProductUrlImage(int codigo) {
    String imageUrl =
        'https://sankhya.stoky.dev.br/mgecom/downloadImgProduto.mgecom?codProd=$codigo&noResize=true';

    return Image.network(
      imageUrl,
      errorBuilder: (context, exception, strackTrace) {
        return Image.network(
          'https://vrmetalurgica.com.br/painel/img/semimagem.png',
        );
      },
    );
  }

  Widget _getProdutctBadges(ProductModel product) {
    return Row(
      children: [
        BadgeComponent(product.codigo.toString()),
        const SizedBox(width: 5),
        BadgeComponent(product.marca.titleCase),
        const SizedBox(width: 5),
        BadgeComponent(product.unidade.titleCase),
      ],
    );
  }

  Widget _getProductDescription(ProductModel product) {
    return Container(
      child: Text(
        product.descricao.titleCase,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: product.estaEmPromocao! ? Colors.red : selectionColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _getProductIconIndicator(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          color: Colors.black54,
          child: Icon(
            icon,
            size: 20,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }

  Widget _getProductValue(ProductModel product) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: Text(
        'R\$ ${product.valor.toStringAsFixed(2)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _getProductReference(ProductModel product) {
    return Text(
      product.referencia!,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 12,
      ),
    );
  }

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductSankhyaService>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    //List<ProductModel> products = ProductListData.products;
    // ProductSankhyaService products = Provider.of(context);
    SearchProductSankhya products = Provider.of(context);

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return _refreshProducts(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListView.builder(
            itemCount: products.productsCount,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var product = products.items[index];

              return Container(
                height: 100,
                margin: EdgeInsets.only(bottom: 12),
                child: CustomCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 80,
                            color: Colors.white,
                            child: _getProductUrlImage(product.codigo),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getProdutctBadges(product),
                            _getProductDescription(product),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (product.novidade!)
                                  _getProductIconIndicator(Icons.star),
                                if (product.chegouNoEstoque!)
                                  _getProductIconIndicator(Icons.info),
                                if (product.estaEmPromocao!)
                                  _getProductIconIndicator(Icons.shopping_cart),
                                _getProductValue(product),
                                _getProductReference(product),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
