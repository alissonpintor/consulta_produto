import 'package:consulta_produto/services/products/product_sankhya_service.dart';
import 'package:consulta_produto/services/products/search_product_sankhya.dart';
import 'package:consulta_produto/utils/consts.dart';
import 'package:consulta_produto/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderContentComponent extends StatelessWidget {
  const HeaderContentComponent({super.key});

  void _onSubmit(String value, BuildContext context) {
    Provider.of<SearchProductSankhya>(
      context,
      listen: false,
    ).searchProdutcts(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ),
          ),
        // if (!Responsive.isMobile(context))
        Expanded(
          child: TextField(
            onSubmitted: (value) {
              _onSubmit(value, context);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: cardBackgroundColor,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              hintText: 'Search',
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 21,
              ),
            ),
          ),
        ),
        if (Responsive.isMobile(context))
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.info,
                  color: Colors.grey,
                  size: 25,
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
              // InkWell(
              //   onTap: () => Scaffold.of(context).openEndDrawer(),
              //   child: CircleAvatar(
              //     backgroundColor: Colors.transparent,
              //     child: Image.asset(
              //       "assets/images/logo.png",
              //       width: 32,
              //     ),
              //   ),
              // ),
            ],
          ),
      ],
    );
  }
}
