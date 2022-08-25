import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/login_provider.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/resources/padding_manager.dart';

import '../../providers/repository_providers.dart';
import '../project_widgets.dart';
import 'login_widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _email = ref.watch(emailProvider);
    final _password = ref.watch(passwordProvider);
    final _auth = ref.watch(authRepositoryProvider);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidgetAuthPages(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WelcomeTextWidget(),
                  Padding(
                    padding: PaddingManager.p10,
                    child: Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: contentContainerDecoration,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const EmailTextField(),
                            const SizedBox(height: 30),
                            const PasswordTextField(),
                            const SizedBox(
                              height: 20,
                            ),
                            LoginButton(
                              auth: _auth,
                              email: _email,
                              password: _password,
                              ),
                            const RegisterButton()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
