import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static TextStyle buildTextStyle(Color color, double fontSize,
      FontWeight fontWeight, FontStyle fontStyle) {
    return GoogleFonts.roboto(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle);
  }

  static RoundedRectangleBorder buildRoundedBorder(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static BorderRadiusGeometry buildBorderRadius(double radius) {
    return BorderRadius.all(
      Radius.circular(radius),
    );
  }

  static Decoration buildBoxDecoration(double radius, Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: buildBorderRadius(radius),
    );
  }
}
