import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Themes/themes.dart';
import '../../../resources/style_manager.dart';

class RestaurantFields extends StatelessWidget {
  const RestaurantFields({
    required this.inputType,
    required this.hintText,
    required this.obscure,
    Key? key,
  }) : super(key: key);

  final TextInputType inputType;

  final String? hintText;
  final bool obscure;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: Material(
          borderRadius: BorderRadius.circular(30),
          elevation: 10,
          child: TextField(
            keyboardType: inputType,
            decoration: InputDecoration(
              enabledBorder: Styles.buildOutlineBorder(accentColor, 30),
              border: Styles.buildOutlineBorder(accentColor, 30),
              hintText: hintText,
              filled: true,
              fillColor: mainColor,
              hintStyle: GoogleFonts.roboto(
                color: accentColor,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            obscureText: obscure,
            autocorrect: false,
          ),
        ),
      );
}
