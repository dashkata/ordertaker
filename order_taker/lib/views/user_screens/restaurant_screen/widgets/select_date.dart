import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/user_restaurant_providers.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectDateWidget extends ConsumerWidget {
  const SelectDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      height: 60,
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          border: Styles.buildOutlineBorder(
            Colors.grey,
            20,
          ),
          focusedBorder: Styles.buildOutlineBorder(
            Colors.grey,
            20,
          ),
          contentPadding: PaddingManager.p3,
          helperText: text.select_date,
          hintText: ref.watch(
            userDateProvider,
          ),
        ),
        onTap: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDateTimePicker(context, ref),
      ),
    );
  }
}
