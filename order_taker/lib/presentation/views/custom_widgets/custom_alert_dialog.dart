import 'package:flutter/material.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import 'custom_remove_focus.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.content,
    Key? key,
    this.actions,
    this.title,
  }) : super(key: key);
  final Widget content;
  final List<Widget>? actions;
  final Widget? title;

  @override
  Widget build(BuildContext context) => RemoveFocusDetector(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          title: title,
          content: content,
          backgroundColor: mainColor,
          actions: actions,
        ),
      );
}
