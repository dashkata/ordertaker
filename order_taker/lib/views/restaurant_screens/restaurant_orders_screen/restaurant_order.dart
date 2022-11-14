import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/order_model.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import 'controllers/restaurant_orders_provider.dart';
import 'restaurant_order_arguments.dart';

part 'widgets/restaurant_order_fab.dart';

part 'widgets/order_container.dart';

class RestaurantOrders extends StatelessWidget {
  const RestaurantOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantOrderArguments =
        ModalRoute.of(context)!.settings.arguments as RestaurantOrderArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders for table ${restaurantOrderArguments.id}',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      floatingActionButton: _RestaurantOrderFABRow(
        restaurantOrderArguments: restaurantOrderArguments,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      drawer: const CustomDrawer(),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final AsyncValue<List<Order>> orders = ref.watch(
              restaurantOrdersProvider(restaurantOrderArguments),
            );
            return RefreshIndicator(
              color: accentBlackColor,
              backgroundColor: complementaryColor,
              child: orders.when(
                data: (data) {
                  ref.watch(docChangesProvider).whenData(
                    (value) {
                      if (value.docs.isNotEmpty) {
                        return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'New order just arrived!',
                            ),
                          ),
                        );
                      }
                    },
                  );
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20,
                      ),
                      child: _OrderContainer(
                        order: data[index],
                        tableId: restaurantOrderArguments.id,
                      ),
                    ),
                  );
                },
                error: (e, s) => ErrorAlertDialog(
                  errorMessage: e.toString(),
                ),
                loading: () => const CustomProgressIndicator(),
              ),
              onRefresh: () async => ref.refresh(
                restaurantOrdersProvider(restaurantOrderArguments),
              ),
            );
          },
        ),
      ),
    );
  }
}
