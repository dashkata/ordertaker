
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/providers/user_restaurant_providers.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';

class NumberOfPeopleWidget extends ConsumerWidget {
  const NumberOfPeopleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: PaddingManager.p2,
      child: SizedBox(
        height: 60,
        child: TextField(
          onChanged: (value) => ref.read(peopleProvider.notifier).update(
                (state) => int.parse(value),
              ),
          decoration: InputDecoration(
            contentPadding: PaddingManager.p3,
            border: Styles.buildOutlineBorder(
              Colors.grey,
              20,
            ),
            helperText: text.enter_the_number_of_people,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
