import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/controller_providers.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../controllers/login_screen_providers.dart';
import '../../project_widgets.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(loginEmailControllerProvider);
    final password = ref.watch(loginPasswordControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
      child: CustomButton(
        buttonText: AppLocalizations.of(context)!.login,
        buttonFunc: () async {
          if (email != '' && password != '') {
            await ref
                .read(loginControllerProvider.notifier)
                .login(
                  email,
                  password,
                  context,
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
              builder: (_) => const ErrorAlertDialog(
                errorMessage: 'Please enter text in both fields!',
              ),
            );
          }
        },
      ),
    );
  }
}
