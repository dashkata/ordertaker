import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../themes/themes.dart';
import '../project_widgets.dart';
import '../resources/padding_manager.dart';
import '../resources/style_manager.dart';
import 'widgets/email_text_field.dart';
import 'widgets/login_button.dart';
import 'widgets/password_text_field.dart';
import 'widgets/register_button.dart';
import 'widgets/welcome_text_widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => UnfocusDetector(
        child: Scaffold(
          backgroundColor: mainColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const WelcomeTextWidget(),
                    Padding(
                      padding: PaddingManager.p10,
                      child: Material(
                        elevation: 10,
                        borderRadius: Styles.buildBorderRadius(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: contentContainerDecoration,
                          width: double.infinity,
                          child: Column(
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
            ),
          ),
        ),
      );
}
