import 'package:flutter/material.dart';

Color iconbuttonColor = Colors.amber[400] as Color;
Color backgroundColor = Colors.amber[200] as Color;
Color buttonColor = Colors.orange[400] as Color;
Color appBarColor = const Color.fromARGB(255, 235, 184, 90);
Color cardColor = Colors.white60;

TextStyle alertTextStyle = TextStyle(
  letterSpacing: 0.5,
  fontSize: 20,
  fontStyle: FontStyle.italic,
  color: Colors.black54,
  height: 2,
);

BoxConstraints constraints() {
  return const BoxConstraints(
      minWidth: 0,
      minHeight: 0,
      maxHeight: double.infinity,
      maxWidth: double.infinity);
}
