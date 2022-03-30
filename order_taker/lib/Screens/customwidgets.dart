import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';

class DialogButtons extends StatelessWidget {
  const DialogButtons({
    Key? key,
    required this.buttonText,
    required this.buttonFunc,
  }) : super(key: key);

  final String? buttonText;
  final void Function() buttonFunc;

  @override
  Widget build(BuildContext context) {
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

class NormalButtons extends StatelessWidget {
  const NormalButtons({
    Key? key,
    required this.buttonText,
    required this.buttonFunc,
  }) : super(key: key);

  final String? buttonText;
  final void Function() buttonFunc;

  @override
  Widget build(BuildContext context) {
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
}

class TextFields extends StatelessWidget {
  const TextFields({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.obscure,
  }) : super(key: key);

  final String? hintText;
  final IconData icon;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
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
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
    );
  }
}
