import 'package:consulta_produto/component/header_content_component.dart';
import 'package:consulta_produto/component/product_list_component.dart';
import 'package:flutter/material.dart';

class MainContentComponent extends StatelessWidget {
  const MainContentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          const HeaderContentComponent(),
          const SizedBox(height: 18),
          ProductListComponent(),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
