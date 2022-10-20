import 'package:flutter/material.dart';

// const Color accentColor = Color.fromARGB(255, 71, 58, 47);
// const Color complementaryColor = Color.fromARGB(255, 223, 213, 182);
// const Color mainColor = Color.fromARGB(255, 236, 229, 191);
const Color accentBlackColor = Color(0xff3D3C42);
const Color complementaryColor2 = Color(0xffF1A661);
const Color complementaryColor = Color(0xffFFD8A9);
const Color mainColor = Color(0xffFDEEDC);

Color appBarColor = mainColor;
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
