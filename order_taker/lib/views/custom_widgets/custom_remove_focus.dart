
import 'package:flutter/material.dart';

class RemoveFocusDetector extends StatelessWidget {
  const RemoveFocusDetector({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
    child: child,
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
  );
}