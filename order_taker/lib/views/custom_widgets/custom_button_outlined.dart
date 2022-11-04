import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class CustomButtonOutlined extends StatelessWidget {
  const CustomButtonOutlined({
    required this.buttonText,
    required this.buttonFunc,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback? buttonFunc;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: complementaryColor2,
            width: 2,
          ),
          backgroundColor: complementaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: buttonFunc,
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.headline1,
        ),
      );
}
