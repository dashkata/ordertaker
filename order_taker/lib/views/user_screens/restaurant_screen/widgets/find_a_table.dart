import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/views/resources/style_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindATableButton extends ConsumerWidget {
  const FindATableButton({
    Key? key,
    required this.resTitle,
  }) : super(key: key);

  final String resTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: GFButton(
        onPressed: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDetailsDialog(context, resTitle, ref),
        elevation: 10,
        shape: GFButtonShape.pills,
        text: text.find_a_table,
        color: mainColor,
        textStyle: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
