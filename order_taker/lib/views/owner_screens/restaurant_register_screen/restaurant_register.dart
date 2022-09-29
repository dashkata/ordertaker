import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/controller_providers.dart';
import '../../../providers/restaurant_register_provider.dart';
import '../../../themes/themes.dart';

import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';

part 'widgets/back_arrow_fab.dart';
part 'widgets/get_started_button.dart';
part 'widgets/name_textfield_row.dart';

class RestaurantRegister extends ConsumerWidget {
  const RestaurantRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        floatingActionButton: const _BackArrowFAB(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
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
                          padding: PaddingManager.p6,
                          child: Text(
                            'Register a restaurant',
                            style: GoogleFonts.roboto(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: accentColor,
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
                              const _NameTextFieldRow(),
                              TextFields(
                                func: (value) => ref
                                    .read(
                                      restaurantRegisterProvider.notifier,
                                    )
                                    .updateText(
                                      restaurantEmailProvider,
                                      value,
                                    ),
                                hintText: 'Email Address',
                                icon: Icons.mail,
                                obscure: false,
                                inputType: TextInputType.emailAddress,
                              ),
                              TextFields(
                                hintText: 'Password',
                                icon: Icons.password,
                                obscure: true,
                                inputType: TextInputType.text,
                                func: (value) => ref
                                    .read(
                                      restaurantRegisterProvider.notifier,
                                    )
                                    .updateText(
                                      restaurantPasswordProvider,
                                      value,
                                    ),
                              ),
                              TextFields(
                                func: (value) => ref
                                    .read(
                                      restaurantRegisterProvider.notifier,
                                    )
                                    .updateText(
                                      restaurantPhoneProvider,
                                      value,
                                    ),
                                hintText: 'Mobile Number',
                                icon: Icons.phone,
                                obscure: false,
                                inputType: TextInputType.number,
                              ),
                              TextFields(
                                hintText: 'Restaurant name',
                                inputType: TextInputType.text,
                                icon: Icons.restaurant,
                                obscure: false,
                                func: (value) => ref
                                    .read(
                                      restaurantRegisterProvider.notifier,
                                    )
                                    .updateText(
                                      restaurantNameProvider,
                                      value,
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
            )
          ],
        ),
      );
}
