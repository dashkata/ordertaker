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

  static Widget button(String? buttonText, void Function() buttonFunc) {
    return ConstrainedBox(
      constraints: Themes.constraints(),
      child: SizedBox(
        width: 200,
        height: 50,
        child: GFButton(
          onPressed: buttonFunc,
          text: buttonText,
          shape: GFButtonShape.pills,
          size: GFSize.LARGE,
          color: Themes().buttonColor,
          fullWidthButton: true,
          elevation: 5,
        ),
      ),
    );
  }

  static Widget dialogButtons(String? buttonText, void Function() buttonFunc) {
    return ConstrainedBox(
      constraints: Themes.constraints(),
      child: SizedBox(
        width: 100,
        height: 30,
        child: GFButton(
          onPressed: buttonFunc,
          text: buttonText,
          shape: GFButtonShape.pills,
          size: GFSize.LARGE,
          color: Themes().buttonColor,
          fullWidthButton: true,
          elevation: 5,
        ),
      ),
    );
  }
}
