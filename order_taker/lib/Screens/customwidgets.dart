import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';

class CustomWidgets {
  static Widget returnBackground() {
    return Container(
      color: Colors.amber[200],
    );
  }

  static Widget textField(String? hintText, IconData icon, bool obscure) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: Themes.constraints(),
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: hintText,
            filled: true,
            fillColor: Colors.white60,
          ),
          obscureText: obscure,
          autocorrect: false,
        ),
      ),
    );
  }

  static Widget button(String? buttonText) {
    return ConstrainedBox(
      constraints: Themes.constraints(),
      child: SizedBox(
        width: 200,
        height: 50,
        child: GFButton(
          onPressed: () {},
          text: buttonText,
          shape: GFButtonShape.pills,
          size: GFSize.LARGE,
          color: Colors.orange[400] as Color,
          fullWidthButton: true,
          elevation: 5,
        ),
      ),
    );
  }
}
