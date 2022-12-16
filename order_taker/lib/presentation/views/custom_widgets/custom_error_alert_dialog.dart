import 'package:flutter/material.dart';

import 'custom_alert_dialog.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) => CustomAlertDialog(
        title: Center(
          child: Text(
            'An error has occurred',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        content: Text(
          errorMessage,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      );
}
