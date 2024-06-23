import 'package:consulta_produto/utils/consts.dart';
import 'package:flutter/material.dart';

class BadgeComponent extends StatelessWidget {
  final String badgeText;

  const BadgeComponent(
    this.badgeText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.black54, //selectionColor,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 1,
        ),
        child: Text(
          badgeText,
          style: TextStyle(color: selectionColor),
        ),
      ),
    );
  }
}
