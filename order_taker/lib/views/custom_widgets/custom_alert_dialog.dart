import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../project_widgets.dart';

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
  Widget build(BuildContext context) => UnfocusDetector(
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
