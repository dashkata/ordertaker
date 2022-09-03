import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';

class RestaurantFields extends StatelessWidget {
  const RestaurantFields({
    Key? key,
    required this.inputType,
    required this.hintText,
    required this.obscure,
  }) : super(key: key);

  final TextInputType inputType;

  final String? hintText;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 10,
        child: TextField(
          keyboardType: inputType,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                color: accentColor,
                width: 1,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            hintText: hintText,
            filled: true,
            fillColor: mainColor,
            hintStyle: GoogleFonts.roboto(
                color: accentColor, fontSize: 15, fontWeight: FontWeight.w300),
          ),
          obscureText: obscure,
          autocorrect: false,
        ),
      ),
    );
  }
}
