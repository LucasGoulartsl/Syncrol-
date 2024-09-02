import 'package:flutter/material.dart';

InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Bordas arredondadas
    ),
    filled: true,
    fillColor: Colors.white,
  );
}
