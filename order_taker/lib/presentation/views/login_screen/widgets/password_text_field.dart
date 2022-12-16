import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../controllers/login_screen_providers.dart';

class PasswordTextField extends ConsumerWidget {
  const PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return CustomTextField(
      func: (value) =>
          ref.read(loginPasswordControllerProvider.notifier).update(
                (state) => value,
              ),
      hintText: text.password,
      icon: Icons.password,
      obscure: true,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}
