import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/login_screen/widgets/welcome_text_widgets.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import '../project_widgets.dart';
import 'widgets/email_text_field.dart';
import 'widgets/login_button.dart';
import 'widgets/password_text_field.dart';
import 'widgets/register_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          children: const [
                            EmailTextField(),
                            SizedBox(height: 30),
                            PasswordTextField(),
                            SizedBox(
                              height: 20,
                            ),
                            LoginButton(),
                            RegisterButton()
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
