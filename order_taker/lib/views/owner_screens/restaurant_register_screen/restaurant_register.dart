import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../themes/themes.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/restaurant_register_provider.dart';

part 'widgets/back_arrow_fab.dart';

part 'widgets/get_started_button.dart';

part 'widgets/name_textfield_row.dart';

class RestaurantRegister extends ConsumerWidget {
  const RestaurantRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return UnfocusDetector(
      child: Scaffold(
        floatingActionButton: const _BackArrowFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: PaddingManager.p6,
                        child: Text(
                          text.register_restaurant,
                          style: GoogleFonts.roboto(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: accentBlackColor,
                          ),
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
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: contentContainerDecoration,
                        width: double.infinity,
                        child: Column(
                          children: [
                            _NameTextFieldRow(
                              text: text,
                            ),
                            CustomTextField(
                              func: (value) => ref
                                  .read(
                                    restaurantRegisterEmailControllerProvider
                                        .notifier,
                                  )
                                  .update(
                                    (state) => value,
                                  ),
                              hintText: text.email_address,
                              icon: Icons.mail,
                              obscure: false,
                              textInputAction: TextInputAction.next,
                              inputType: TextInputType.emailAddress,
                            ),
                            CustomTextField(
                              hintText: text.password,
                              icon: Icons.password,
                              obscure: true,
                              textInputAction: TextInputAction.next,
                              inputType: TextInputType.text,
                              func: (value) => ref
                                  .read(
                                    restaurantRegisterPasswordControllerProvider
                                        .notifier,
                                  )
                                  .update(
                                    (state) => value,
                                  ),
                            ),
                            CustomTextField(
                              func: (value) => ref
                                  .read(
                                    restaurantRegisterPhoneControllerProvider
                                        .notifier,
                                  )
                                  .update(
                                    (state) => value,
                                  ),
                              hintText: text.mobile_number,
                              icon: Icons.phone,
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              inputType: TextInputType.number,
                            ),
                            CustomTextField(
                              hintText: text.restaurant_name,
                              inputType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              icon: Icons.restaurant,
                              obscure: false,
                              func: (value) => ref
                                  .read(
                                    restaurantRegisterNameControllerProvider
                                        .notifier,
                                  )
                                  .update(
                                    (state) => value,
                                  ),
                            ),
                            const _ConfirmButton(),
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
