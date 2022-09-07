import 'package:flutter/material.dart';

class Styles {
  static RoundedRectangleBorder buildRoundedBorder(double radius) =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      );

  static BorderRadius buildBorderRadius(double radius) => BorderRadius.all(
        Radius.circular(radius),
      );

  static Decoration buildBoxDecoration(double radius, Color color) =>
      BoxDecoration(
        color: color,
        borderRadius: buildBorderRadius(radius),
      );

  static InputBorder buildOutlineBorder(Color color, double radius) =>
      OutlineInputBorder(
        borderRadius: buildBorderRadius(radius),
        borderSide: BorderSide(
          color: color,
        ),
      );
}
