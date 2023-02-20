import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/login_screen_providers.dart';

class ForgotPasswordButton extends ConsumerWidget {
  const ForgotPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => TextButton(
        onPressed: () => ref
            .read(loginViewModelProvider.notifier)
            .navigateToForgotPassword(),
        child: Text(
          'Forgot Password?',
          style: Theme.of(context).textTheme.headline1,
        ),
      );
}
