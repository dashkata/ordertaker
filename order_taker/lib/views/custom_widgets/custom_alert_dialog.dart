import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.content,
    this.actions,
    this.title,
  }) : super(key: key);
  final Widget content;
  final List<Widget>? actions;
  final Widget? title;

  @override
  Widget build(BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        title: title,
        content: content,
        backgroundColor: mainColor,
        actions: actions,
      );
}
