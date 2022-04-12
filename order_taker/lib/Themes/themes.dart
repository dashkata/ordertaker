import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Color iconbuttonColor = Colors.amber[400] as Color;
Color backgroundColor = Colors.amber[200] as Color;
Color buttonColor = Colors.orange[400] as Color;
Color appBarColor = const Color.fromARGB(255, 235, 184, 90);
Color cardColor = Colors.white60;
// Color accentColor = Colors.black;
// Color complementaryColor = Colors.deepOrange;
// Color mainColor = HexColor("#EFEBD6");
Color accentColor = Color.fromARGB(255, 58, 49, 41);
Color complementaryColor = Color(0xffFAF6E9);
Color mainColor = Color.fromARGB(255, 236, 229, 191);
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
