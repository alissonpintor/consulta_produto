import 'package:consulta_produto/model/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.search, title: 'Consulta'),
    MenuModel(icon: Icons.person, title: 'Profile'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}
