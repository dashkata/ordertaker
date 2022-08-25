import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/route_manager.dart';

import '../../providers/login_provider.dart';
import '../../repositories/auth_repository.dart';
import '../project_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginText extends StatelessWidget {
  const LoginText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required AuthRepository auth,
    required String email,
    required String password,
  })  : _auth = auth,
        _email = email,
        _password = password,
        super(key: key);

  final AuthRepository _auth;
  final String _email;
  final String _password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
      child: NormalButtons(
          buttonText: AppLocalizations.of(context)!.login,
          buttonFunc: () async {
            GFToast.showToast(
              await _auth.signIn(
                email: _email,
                password: _password,
              ),
              context,
              toastDuration: 5,
            );
            Navigator.popAndPushNamed(context, '/auth');
          }),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginText(text: text.no_account),
        TextButton(
          onPressed: () {
            Navigator.popAndPushNamed(
              context,
              Routes.register,
            );
          },
          child: LoginText(
            text: text.register,
          ),
        )
      ],
    );
  }
}

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Row(
      children: [
        Padding(
          padding: PaddingManager.p13,
          child: Text(
            text.welcome,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    );
  }
}

class EmailTextField extends ConsumerWidget {
  const EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return TextFields(
      func: (value) =>
          ref.read(emailProvider.notifier).update((state) => value),
      hintText: text.email,
      icon: Icons.email,
      obscure: false,
      inputType: TextInputType.emailAddress,
    );
  }
}

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
