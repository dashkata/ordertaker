import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Themes/themes.dart';
import '../../../providers/controller_providers.dart';
import '../../../providers/repository_providers.dart';
import '../../project_widgets.dart';
import '../restaurant_orders_screen/controllers/restaurant_orders_provider.dart';
import '../restaurant_orders_screen/restaurant_order.dart';
import 'controllers/restaurant_tables_providers.dart';

class RestaurantTables extends ConsumerWidget {
  const RestaurantTables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(

        body: Stack(
          children: [
            const BackgroundWidget(),
            SafeArea(
              child: Center(
                child: Consumer(
                  builder: (context, ref, child) => ref
                      .watch(fetchRestaurantTitleProvider)
                      .when(
                        data: (title) {
                          final asyncTables = ref.watch(
                            tablesProvider(title),
                          );
                          return asyncTables.when(
                            data: (tables) => ListView.builder(
                              itemCount: tables.length,
                              itemBuilder: (context, index) => NormalButtons(
                                buttonText: tables[index],
                                buttonFunc: () {
                                  ref
                                      .read(
                                        restaurantTablesNotifierProvider
                                            .notifier,
                                      )
                                      .navigateToOrders(
                                        int.parse(
                                          tables[index]
                                              .replaceAll('Table ', ''),
                                        ),
                                        title,
                                      );
                                },
                              ),
                            ),
                            error: (e, s) => Text(e.toString()),
                            loading: LoadingIndicator.new,
                          );
                        },
                        error: (e, s) => Text(e.toString()),
                        loading: LoadingIndicator.new,
                      ),
                ),
              ),
            ),
          ],
        ),
      );
}
