// lib/views/text_styles.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle syncrolTextStyle() {
  return GoogleFonts.notoSansDisplay(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}

InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.grey.shade600, // Cor do texto de dica
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Ajusta o padding interno
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.blue.shade800, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
    ),
    filled: true,
    fillColor: Colors.white,
  );
}

ButtonStyle elevatedButtonStyle(Color backgroundColor) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: backgroundColor,
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
