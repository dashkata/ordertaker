import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/controller_providers.dart';
import '../../../../providers/restaurant_register_provider.dart';
import '../../../project_widgets.dart';

class ConfirmButton extends ConsumerWidget {
  const ConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstName = ref.watch(restaurantFirstNameProvider);
    final lastName = ref.watch(restaurantLastNameProvider);
    final email = ref.watch(restaurantEmailProvider);
    final password = ref.watch(restaurantPasswordProvider);
    final phoneNumber = ref.watch(restaurantPhoneProvider);
    final restaurantName = ref.watch(
      restaurantNameProvider,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: NormalButtons(
        buttonText: 'Get Started',
        buttonFunc: () async {
          await ref
              .read(
                restaurantRegisterProvider.notifier,
              )
              .signUp(
                firstName,
                lastName,
                email,
                password,
                phoneNumber,
                restaurantName,
              );
          ref
              .read(
                restaurantRegisterProvider.notifier,
              )
              .navigateToLogin();
        },
      ),
    );
  }
}
