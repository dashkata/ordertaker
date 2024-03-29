import 'package:flutter/material.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../resources/style_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.suffix,
    required this.hintText,
    required this.icon,
    required this.obscure,
    required this.inputType,
    required this.textInputAction,
    required this.func,
    Key? key,
  }) : super(key: key);

  final String? hintText;
  final IconData icon;
  final bool obscure;
  final TextInputType inputType;
  final void Function(String)? func;
  final TextInputAction textInputAction;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: DoubleTextField(
          suffix: suffix,
          func: func,
          inputType: inputType,
          icon: icon,
          hintText: hintText,
          obscure: obscure,
          textInputAction: textInputAction,
        ),
      );
}

class DoubleTextField extends StatelessWidget {
  const DoubleTextField({
    this.suffix,
    required this.func,
    required this.inputType,
    required this.icon,
    required this.hintText,
    required this.obscure,
    required this.textInputAction,
    Key? key,
  }) : super(key: key);

  final TextInputType inputType;
  final IconData icon;
  final String? hintText;
  final bool obscure;
  final TextInputAction textInputAction;
  final Widget? suffix;
  final void Function(String)? func;

  @override
  Widget build(BuildContext context) => SizedBox(
        child: Material(
          borderRadius: Styles.buildBorderRadius(30),
          elevation: 5,
          child: TextField(
            onChanged: func,
            keyboardType: inputType,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: accentBlackColor,
              ),
              enabledBorder: Styles.buildOutlineBorder(
                accentBlackColor,
                30,
              ),
              border: Styles.buildOutlineBorder(
                accentBlackColor,
                30,
              ),
              focusedBorder: Styles.buildOutlineBorder(
                accentBlackColor,
                30,
              ),
              prefixIconColor: accentBlackColor,
              hintText: hintText,
              filled: true,
              fillColor: mainColor,
              hintStyle: Theme.of(context).textTheme.headline6,
              suffixIcon: suffix,
            ),
            obscureText: obscure,
            autocorrect: false,
            textInputAction: textInputAction,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
      );
}
