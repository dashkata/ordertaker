import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Themes/themes.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/user_register_providers.dart';

part 'widgets/bottom_texts.dart';

part 'widgets/name_row.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return UnfocusDetector(
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundWidgetAuthPages(),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: PaddingManager.p13,
                            child: Text(
                              text.register,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: PaddingManager.p10,
                        child: Material(
                          elevation: 10,
                          borderRadius: Styles.buildBorderRadius(30),
                          child: Container(
                            decoration: contentContainerDecoration,
                            width: double.infinity,
                            padding: PaddingManager.p8,
                            child: Column(
                              children: [
                                _NameRow(text: text),
                                TextFields(
                                  func: (value) => ref
                                      .read(
                                        registerEmailControllerProvider
                                            .notifier,
                                      )
                                      .update((state) => value),
                                  hintText: text.email_address,
                                  textInputAction: TextInputAction.next,
                                  icon: Icons.mail,
                                  obscure: false,
                                  inputType: TextInputType.emailAddress,
                                ),
                                TextFields(
                                  func: (value) => ref
                                      .read(
                                        registerPasswordControllerProvider
                                            .notifier,
                                      )
                                      .update((state) => value),
                                  hintText: text.password,
                                  textInputAction: TextInputAction.next,
                                  icon: Icons.lock,
                                  obscure: true,
                                  inputType: TextInputType.text,
                                ),
                                TextFields(
                                  func: (value) => ref
                                      .read(
                                        registerPhoneNumberControllerProvider
                                            .notifier,
                                      )
                                      .update((state) => value),
                                  hintText: text.mobile_number,
                                  textInputAction: TextInputAction.done,
                                  icon: Icons.phone,
                                  obscure: false,
                                  inputType: TextInputType.phone,
                                ),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final email = ref.watch(
                                      registerEmailControllerProvider,
                                    );
                                    final password = ref.watch(
                                      registerPasswordControllerProvider,
                                    );
                                    final firstName = ref.watch(
                                      registerFirstNameControllerProvider,
                                    );
                                    final lastName = ref.watch(
                                      registerLastNameControllerProvider,
                                    );
                                    final mobileNumber = ref.watch(
                                      registerPhoneNumberControllerProvider,
                                    );
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 40.0),
                                      child: NormalButtons(
                                        buttonText: text.register,
                                        buttonFunc: () async {
                                          await ref
                                              .read(
                                                userRegisterProvider.notifier,
                                              )
                                              .register(
                                                email,
                                                password,
                                                mobileNumber,
                                                firstName,
                                                lastName,
                                              )
                                              .then(
                                                (value) => ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Register successful',
                                                    ),
                                                  ),
                                                ),
                                                onError: (e, s) =>
                                                    ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      e.toString(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                _BottomTexts(text: text),
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
          ],
        ),
      ),
    );
  }
}
