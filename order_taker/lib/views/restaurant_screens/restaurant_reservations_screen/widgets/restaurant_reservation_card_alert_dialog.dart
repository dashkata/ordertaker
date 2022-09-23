import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';
import '../controllers/restaurant_reservation_provider.dart';

class CardAlertDialog extends ConsumerWidget {
  const CardAlertDialog({
    required this.reservation,
    required this.args,
    Key? key,
  }) : super(key: key);

  final Reservation reservation;
  final RestaurantOrderArguments args;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AlertDialog(
        title: Text(
          'Are you sure you want to set this as current reservation?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                ref
                    .read(
                      restaurantReservationsControllerProvider.notifier,
                    )
                    .setCurrentReservation(
                      reservation,
                      args.restaurantTitle,
                      args.id,
                    );
                navigatorKey.currentState!.pop();
              },
              icon: const Icon(
                Icons.check_circle,
              ),
            ),
            IconButton(
              onPressed: () => navigatorKey.currentState!.pop(),
              icon: const Icon(
                Icons.cancel,
              ),
            ),
          ],
        ),
      );
}
