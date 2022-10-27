import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/login_screen_providers.dart';

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
        Text(
          text.no_account,
          style: Theme.of(context).textTheme.headline3,
        ),
        TextButton(
          onPressed: () =>
              ref.read(loginControllerProvider.notifier).navigateToRegister(),
          child: Text(
            text.register,
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ],
    );
  }
}
