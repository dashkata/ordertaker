import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/reservation_model.dart';
import '../../../providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/route_manager.dart';
import '../restaurant_orders_screen/controllers/restaurant_orders_provider.dart';
import '../restaurant_orders_screen/restaurant_order.dart';
import '../restaurant_orders_screen/restaurant_order_arguments.dart';
import 'controllers/restaurant_reservation_provider.dart';

part 'widgets/restaurant_reservation_card.dart';

part 'widgets/restaurant_reservation_card_alert_dialog.dart';

class RestaurantReservations extends ConsumerWidget {
  const RestaurantReservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantOrderArguments =
        ModalRoute.of(context)!.settings.arguments as RestaurantOrderArguments;
    return Scaffold(
      floatingActionButton: RestaurantOrderFAB(
        icon: Icons.table_bar,
        onPressed: () => ref
            .read(restaurantOrderNotifierProvider.notifier)
            .navigateToTables(),
        heroTag: 'orderFab1',
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Column(
              children: [
                Text(
                  'Table ${restaurantOrderArguments.id} reservations',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final AsyncValue<List<Reservation>> asyncReservations =
                        ref.watch(
                      restaurantReservationsProvider(
                        restaurantOrderArguments,
                      ),
                    );
                    return asyncReservations.when(
                      data: (reservations) => ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            _RestaurantReservationCard(
                          reservation: reservations[index],
                          args: restaurantOrderArguments,
                        ),
                        itemCount: reservations.length,
                      ),
                      error: (e, s) => Text(e.toString()),
                      loading: () => const LoadingIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
