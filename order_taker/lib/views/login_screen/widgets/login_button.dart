import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/login_provider.dart';
import 'package:order_taker/views/project_widgets.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _email = ref.watch(emailProvider);
    final _password = ref.watch(passwordProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
      child: NormalButtons(
        buttonText: AppLocalizations.of(context)!.login,
        buttonFunc: () => ref.read(loginStateProvider.notifier).login(
              _email,
              _password,
              context,
            ),
      ),
    );
  }
}
