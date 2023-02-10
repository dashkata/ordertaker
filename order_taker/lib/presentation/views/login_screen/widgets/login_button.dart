import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../controllers/login_screen_providers.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(loginEmailControllerProvider);
    final password = ref.watch(loginPasswordControllerProvider);
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
      child: CustomButton(
        buttonText: text.login,
        buttonFunc: () async {
          if (email != '' && password != '') {
            await ref
                .read(loginViewModelProvider.notifier)
                .login(
                  email: email,
                  password: password,
                )
                .catchError(
                  (e) => showDialog(
                    context: context,
                    builder: (_) => ErrorAlertDialog(
                      errorMessage: e.toString(),
                    ),
                  ),
                );
          } else {
            await showDialog(
              context: context,
              builder: (_) => ErrorAlertDialog(
                errorMessage: text.enter_text_in_all_fields,
              ),
            );
          }
        },
      ),
    );
  }
}
