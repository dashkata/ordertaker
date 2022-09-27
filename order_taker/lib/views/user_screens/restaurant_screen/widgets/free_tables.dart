import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/controller_providers.dart';
import '../../../../providers/restaurant_screen_providers.dart';
import '../../../project_widgets.dart';

class TablesAlertDialog extends StatelessWidget {
  const TablesAlertDialog({
    required this.restaurantTitle,
    Key? key,
  }) : super(key: key);
  final String restaurantTitle;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(text.available_tables),
      content: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final AsyncValue<Map<String, bool>> availableTables =
              ref.watch(fetchFreeTablesProvider(restaurantTitle));
          return availableTables.when(
            data: (tables) => SizedBox(
              height: 300,
              width: 200,
              child: ListView.builder(
                itemCount: tables.length,
                itemBuilder: (context, index) => NormalButtons(
                  buttonText: tables.keys.elementAt(index),
                  buttonFunc: tables.values.elementAt(index)
                      ? () => ref
                          .read(restaurantDialogNotifierProvider.notifier)
                          .navigateToConfirm(
                            restaurantTitle,
                            ref,
                            tables.keys.elementAt(index),
                          )
                      : null,
                ),
              ),
            ),
            error: (e, s) => Text(e.toString()),
            loading: () => const LoadingIndicator(),
          );
        },
      ),
    );
  }
}
