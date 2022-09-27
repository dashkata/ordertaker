import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/login_provider.dart';
import '../../project_widgets.dart';

class PasswordTextField extends ConsumerWidget {
  const PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return TextFields(
      func: (value) =>
          ref.read(passwordProvider.notifier).update((state) => value),
      hintText: text.password,
      icon: Icons.password,
      obscure: true,
      inputType: TextInputType.text,
    );
  }
}
