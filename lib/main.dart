import 'dart:convert';

import 'package:consulta_produto/pages/home_page.dart';
import 'package:consulta_produto/pages/login_page.dart';
import 'package:consulta_produto/routes.dart';
import 'package:consulta_produto/services/auth/auth_service.dart';
import 'package:consulta_produto/services/products/product_sankhya_service.dart';
import 'package:consulta_produto/services/products/product_service.dart';
import 'package:consulta_produto/services/products/search_product_sankhya.dart';
import 'package:consulta_produto/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io' show Platform;

void main() async {
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      minimumSize: Size(1280, 720),
      maximumSize: Size(1920, 1080),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductSankhyaService()),
        ChangeNotifierProvider(create: (context) => SearchProductSankhya()),
      ],
      child: MaterialApp(
        title: 'Consulta Produtos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          brightness: Brightness.dark,
        ),
        routes: {
          AppRoutes.home: (ctx) => const LoginPage(),
          AppRoutes.consulta: (ctx) => const HomePage(),
        },
      ),
    );
  }
}
