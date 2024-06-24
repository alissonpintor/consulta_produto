import 'package:consulta_produto/components/card_component.dart';
import 'package:consulta_produto/services/products/product_sankhya_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCharacteristicsComponent extends StatelessWidget {
  const ProductCharacteristicsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ProductSankhyaService products = Provider.of(context);

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

    return (products.productsCount == 0)
        ? Center(
            child: Text('Nenhum produto selecionado'),
          )
        : Container(
            margin: EdgeInsets.only(top: 36, bottom: 36, right: 18),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: _getProductUrlImage(products.items[0].codigo),
                    ),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 18),
                      child: CustomCard(
                        child: Text(products.items[0].descricao),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      child: CustomCard(
                        child: Text('Teste'),
                      ),
                    ))
              ],
            ),
          );
  }
}
