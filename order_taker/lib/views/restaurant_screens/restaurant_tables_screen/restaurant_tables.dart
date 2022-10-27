import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Themes/themes.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../project_widgets.dart';
import 'controllers/restaurant_tables_providers.dart';

class RestaurantTables extends ConsumerWidget {
  const RestaurantTables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text.tables,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Center(
          child: Consumer(
            builder: (context, ref, child) =>
                ref.watch(restaurantTitleProvider).when(
                      data: (title) {
                        final asyncTables = ref.watch(
                          tablesProvider(title),
                        );
                        return asyncTables.when(
                          data: (tables) => ListView.builder(
                            itemCount: tables.length,
                            itemBuilder: (context, index) => CustomButton(
                              buttonText: tables[index],
                              buttonFunc: () {
                                ref
                                    .read(
                                      restaurantTablesControllerProvider.notifier,
                                    )
                                    .navigateToOrders(
                                      int.parse(
                                        tables[index].replaceAll('Table ', ''),
                                      ),
                                      title,
                                    );
                              },
                            ),
                          ),
                          error: (e, s) => ErrorAlertDialog(
                            errorMessage: e.toString(),
                          ),
                          loading: CustomProgressIndicator.new,
                        );
                      },
                      error: (e, s) => ErrorAlertDialog(
                        errorMessage: e.toString(),
                      ),
                      loading: CustomProgressIndicator.new,
                    ),
          ),
        ),
      ),
    );
  }
}
