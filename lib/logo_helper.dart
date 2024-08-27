// lib/logo_helper.dart

import 'package:flutter/material.dart';

Image getShoppingCartLogo({double width = 200, double height = 200}) {
  return Image.asset(
    'assets/images/shopping_cart_logo.png', // Certifique-se de que este caminho está correto
    width: width,
    height: height,
  );
}
