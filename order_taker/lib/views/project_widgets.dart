import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/menu_item_model.dart';
import '../providers/auth_provider.dart';
import 'custom_widgets/custom_alert_dialog.dart';
import 'resources/style_manager.dart';

class UnfocusDetector extends StatelessWidget {
  const UnfocusDetector({
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
