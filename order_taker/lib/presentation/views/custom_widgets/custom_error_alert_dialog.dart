import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_alert_dialog.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return CustomAlertDialog(
      title: Center(
        child: Text(
          text.an_error_occurred,
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
}
