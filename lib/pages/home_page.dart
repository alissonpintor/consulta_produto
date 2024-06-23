import 'package:consulta_produto/component/main_content_component.dart';
import 'package:consulta_produto/component/side_menu_component.dart';
import 'package:consulta_produto/utils/responsive.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: !Responsive.isDesktop(context)
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Center(
                child: Text('Right Menu Mobile'),
              ),
            )
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Menu Desktop
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: SizedBox(child: SideMenuWidget()),
              ),
            Expanded(flex: 7, child: MainContentComponent()),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 3,
                child: Center(
                  child: Text('Right Content Desktop'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
