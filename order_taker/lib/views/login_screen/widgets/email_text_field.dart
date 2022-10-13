import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../project_widgets.dart';
import '../controllers/login_screen_providers.dart';

class EmailTextField extends ConsumerWidget {
  const EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return TextFields(
      func: (value) => ref
          .read(loginEmailControllerProvider.notifier)
          .update((state) => value),
      hintText: text.email,
      icon: Icons.email,
      obscure: false,
      inputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}
