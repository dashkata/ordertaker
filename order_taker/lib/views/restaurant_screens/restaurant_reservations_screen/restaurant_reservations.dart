import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/reservation_model.dart';
import '../../project_widgets.dart';
import '../restaurant_orders_screen/restaurant_order_arguments.dart';
import 'controllers/restaurant_reservation_provider.dart';
import 'widgets/restaurant_reservation_card.dart';

class RestaurantReservations extends StatelessWidget {
  const RestaurantReservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantOrderArguments =
        ModalRoute.of(context)!.settings.arguments as RestaurantOrderArguments;
    return Scaffold(
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
                            RestaurantReservationCard(
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
