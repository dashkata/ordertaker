import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color accentColor = Color.fromARGB(255, 71, 58, 47);
// const Color complementaryColor = Color.fromARGB(255, 223, 213, 182);
// const Color mainColor = Color.fromARGB(255, 236, 229, 191);
const Color accentBlackColor = Color(0xff232020);
const Color accentWhiteColor = Color(0xffffffff);
const Color complementaryColor2 = Color(0xfff1a746);
const Color complementaryColor = Color(0xffffffff);
const Color mainColor = Color(0xfff1f0f0);

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

ThemeData getThemeData() => ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.black,
          shape: const StadiumBorder(),
          backgroundColor: complementaryColor2,
          elevation: 5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: complementaryColor2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: complementaryColor2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: complementaryColor2,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        iconTheme: const IconThemeData(color: accentBlackColor),
        elevation: 0,
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.montserrat(
          color: complementaryColor2,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        headline2: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: accentBlackColor,
        ),
        headline3: GoogleFonts.montserrat(
          fontSize: 15,
          color: accentBlackColor,
        ),
        headline4: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: accentWhiteColor,
        ),
        headline5: GoogleFonts.montserrat(
          color: accentBlackColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headline6: GoogleFonts.montserrat(
          color: accentBlackColor,
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
        subtitle2: GoogleFonts.montserrat(
          color: accentBlackColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
