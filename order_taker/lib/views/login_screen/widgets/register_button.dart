import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/views/login_screen/widgets/login_text.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginText(text: text.no_account),
        TextButton(
          onPressed: () =>
              ref.read(loginStateProvider.notifier).navigateToRegister(),
          child: LoginText(
            text: text.register,
          ),
        )
      ],
    );
  }
}
