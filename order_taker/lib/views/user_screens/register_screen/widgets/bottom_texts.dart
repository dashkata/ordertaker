import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/views/resources/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomTexts extends ConsumerWidget {
  const BottomTexts({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.already_a_member,
              style: Theme.of(context).textTheme.headline3,
            ),
            TextButton(
              onPressed: () =>
                  ref.read(userRegisterProvider.notifier).navigateToLogin(),
              child: Text(
                text.login,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.or,
              style: Theme.of(context).textTheme.headline3,
            ),
            TextButton(
              onPressed: () => ref
                  .read(userRegisterProvider.notifier)
                  .navigateToRestaurantRegister(),
              child: Text(
                text.click_here,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Text(
              text.to_register_a_restaurant,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ],
    );
  }
}
