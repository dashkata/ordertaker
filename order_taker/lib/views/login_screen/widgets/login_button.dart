import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/controller_providers.dart';
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
      child: NormalButtons(
        buttonText: AppLocalizations.of(context)!.login,
        buttonFunc: () async {
          await ref.read(loginStateProvider.notifier).login(
                email,
                password,
                context,
              );
          // .then(
          //   (value) => ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('login successful'),
          //     ),
          //   ),
          //   onError: (e, s) => ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(
          //         e.toString(),
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
