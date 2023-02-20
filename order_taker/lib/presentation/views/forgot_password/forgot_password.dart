import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/themes/themes.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_alert_dialog.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_button.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_error_alert_dialog.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_text_field.dart';
import 'package:order_taker/presentation/views/forgot_password/controllers/forgot_password_providers.dart';

import '../custom_widgets/custom_remove_focus.dart';
import '../resources/padding_manager.dart';
import '../resources/style_manager.dart';

part 'widgets/confirm_email_text.dart';
part 'widgets/forgot_password_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RemoveFocusDetector(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
          ),
          backgroundColor: mainColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const _ForgotPasswordText(),
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
                          children: [
                            const _ConfirmEmailText(),
                            Consumer(
                              builder: (context, ref, child) => CustomTextField(
                                func: (value) => ref
                                    .read(emailControllerProvider.notifier)
                                    .update(
                                      (state) => value,
                                    ),
                                hintText: 'Email address',
                                icon: Icons.person,
                                inputType: TextInputType.emailAddress,
                                obscure: false,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final email =
                                    ref.watch(emailControllerProvider);
                                return Padding(
                                  padding: PaddingManager.p1,
                                  child: CustomButton(
                                    buttonText: 'Reset Password',
                                    buttonFunc: () => ref
                                        .read(
                                          forgotPasswordViewModelProvider
                                              .notifier,
                                        )
                                        .forgotPassword(
                                          email: email,
                                        )
                                        .then(
                                      (value) async {
                                        await showDialog(
                                          builder: (context) =>
                                              CustomAlertDialog(
                                            title: Center(
                                              child: Text(
                                                'Check your mail',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ),
                                            content: Text(
                                              'We have sent you an email to reset your password.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                          context: context,
                                        );
                                        Navigator.pop(context);
                                      },
                                      onError: (e, s) => ErrorAlertDialog(
                                        errorMessage: e.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        // child: ,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
