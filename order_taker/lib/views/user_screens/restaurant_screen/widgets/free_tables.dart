import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/controller_providers.dart';
import '../../../../providers/restaurant_screen_providers.dart';
import '../../../project_widgets.dart';

class TablesAlertDialog extends StatelessWidget {
  const TablesAlertDialog({
    Key? key,
    required this.restaurantTitle,
  }) : super(key: key);
  final String restaurantTitle;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text("Available tables"),
        content: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final AsyncValue<List<String>> availableTables =
                ref.watch(fetchFreeTablesProvider(restaurantTitle));
            return availableTables.when(
              data: (tables) => SizedBox(
                height: 300,
                width: 200,
                child: ListView.builder(
                  itemCount: tables.length,
                  itemBuilder: (context, index) => NormalButtons(
                    buttonText: tables[index],
                    buttonFunc: () => ref
                        .read(restaurantDialogNotifierProvider.notifier)
                        .navigateToConfirm(
                          restaurantTitle,
                          ref,
                          tables[index],
                        ),
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
