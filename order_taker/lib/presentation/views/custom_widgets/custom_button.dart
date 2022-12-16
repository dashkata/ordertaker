import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonText,
    required this.buttonFunc,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback? buttonFunc;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: buttonFunc,
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.headline4,
        ),
      );
}
