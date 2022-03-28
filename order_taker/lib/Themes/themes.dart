import 'package:flutter/material.dart';

class Themes {
  Color backgroundColor = Colors.amber[400] as Color;
  Color buttonColor = Colors.orange[400] as Color;

  static BoxConstraints constraints() {
    return const BoxConstraints(
        minWidth: 0,
        minHeight: 0,
        maxHeight: double.infinity,
        maxWidth: double.infinity);
  }
}
