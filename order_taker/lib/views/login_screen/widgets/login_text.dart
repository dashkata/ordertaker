import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline3,
      );
}
