import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/controller_providers.dart';
import '../../project_widgets.dart';

class RestaurantTables extends StatelessWidget {
  const RestaurantTables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            const BackgroundWidget(),
            SafeArea(
              child: Center(
                child: Consumer(
                  builder: (context, ref, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NormalButtons(
                            buttonText: 'Table 1',
                            buttonFunc: () => ref
                                .read(restaurantTablesNotifierProvider.notifier)
                                .navigateToOrders(1),
                          ),
                          NormalButtons(
                            buttonText: 'Table 2',
                            buttonFunc: () => ref
                                .read(restaurantTablesNotifierProvider.notifier)
                                .navigateToOrders(2),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NormalButtons(
                            buttonText: 'Table 3',
                            buttonFunc: () => ref
                                .read(restaurantTablesNotifierProvider.notifier)
                                .navigateToOrders(3),
                          ),
                          NormalButtons(
                            buttonText: 'Table 4',
                            buttonFunc: () => ref
                                .read(restaurantTablesNotifierProvider.notifier)
                                .navigateToOrders(4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
