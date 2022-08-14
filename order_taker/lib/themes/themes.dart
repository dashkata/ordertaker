import 'package:flutter/material.dart';

const Color accentColor = Color.fromARGB(255, 71, 58, 47);
const Color complementaryColor = Color.fromARGB(255, 223, 213, 182);
const Color mainColor = Color.fromARGB(255, 236, 229, 191);
Color appBarColor = accentColor;
TextStyle alertTextStyle = const TextStyle(
  letterSpacing: 0.5,
  fontSize: 20,
  fontStyle: FontStyle.italic,
  color: Colors.black54,
  height: 2,
);
BoxDecoration contentContainerDecoration = const BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(30),
  ),
  color: complementaryColor,
);
