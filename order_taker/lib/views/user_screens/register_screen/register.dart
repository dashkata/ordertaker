import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/user_register_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';
import 'package:order_taker/views/user_screens/register_screen/widgets/bottom_texts.dart';
import 'package:order_taker/views/user_screens/register_screen/widgets/name_row.dart';
import '../../project_widgets.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidgetAuthPages(),
          SafeArea(
            child: Center(
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
                            NameRow(text: text),
                            TextFields(
                              func: (value) => ref
                                  .read(emailProvider.notifier)
                                  .update((state) => value),
                              hintText: text.email_address,
                              icon: Icons.mail,
                              obscure: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            TextFields(
                              func: (value) => ref
                                  .read(passwordProvider.notifier)
                                  .update((state) => value),
                              hintText: text.password,
                              icon: Icons.lock,
                              obscure: true,
                              inputType: TextInputType.text,
                            ),
                            TextFields(
                              func: (value) => ref
                                  .read(phoneNumberProvider.notifier)
                                  .update((state) => value),
                              hintText: text.mobile_number,
                              icon: Icons.phone,
                              obscure: false,
                              inputType: TextInputType.phone,
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final email = ref.watch(emailProvider);
                                final password = ref.watch(passwordProvider);
                                final firstName = ref.watch(firstNameProvider);
                                final lastName = ref.watch(lastNameProvider);
                                final mobileNumber =
                                    ref.watch(phoneNumberProvider);
                                return Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: NormalButtons(
                                    buttonText: text.register,
                                    buttonFunc: () => ref
                                        .read(userRegisterProvider.notifier)
                                        .register(
                                          email,
                                          password,
                                          mobileNumber,
                                          firstName,
                                          lastName,
                                        ),
                                  ),
                                );
                              },
                            ),
                            BottomTexts(text: text),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
