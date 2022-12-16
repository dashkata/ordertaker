import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_remove_focus.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/user_register_providers.dart';

part 'widgets/bottom_texts.dart';
part 'widgets/name_row.dart';
part 'widgets/register_button.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return RemoveFocusDetector(
      child: Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
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
                          style: Theme.of(context).textTheme.headline5,
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
                            CustomTextField(
                              func: (value) => ref
                                  .read(
                                    registerEmailControllerProvider.notifier,
                                  )
                                  .update((state) => value),
                              hintText: text.email_address,
                              textInputAction: TextInputAction.next,
                              icon: Icons.mail,
                              obscure: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            CustomTextField(
                              func: (value) => ref
                                  .read(
                                    registerPasswordControllerProvider.notifier,
                                  )
                                  .update((state) => value),
                              hintText: text.password,
                              textInputAction: TextInputAction.next,
                              icon: Icons.lock,
                              obscure: true,
                              inputType: TextInputType.text,
                            ),
                            CustomTextField(
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
                            const _RegisterButton(),
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
      ),
    );
  }
}
