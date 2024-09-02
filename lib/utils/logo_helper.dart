// lib/logo_helper.dart

import 'package:flutter/material.dart';

Image getShoppingCartLogo({double width = 100, double height = 100}) {
  return Image.asset(
    'assets/images/shopping_cart_logo.png', // Certifique-se de que este caminho está correto
    width: width,
    height: height,
  );
}
