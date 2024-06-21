import 'package:consulta_produto/pages/home_page.dart';
import 'package:consulta_produto/routes.dart';
import 'package:consulta_produto/utils/consts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: BACKGROUND_COLOR,
        brightness: Brightness.dark,
      ),
      routes: {
        AppRoutes.HOME: (ctx) => const HomePage(),
      },
    );
  }
}
