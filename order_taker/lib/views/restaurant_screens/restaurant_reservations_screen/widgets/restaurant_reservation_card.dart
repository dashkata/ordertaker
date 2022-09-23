import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Themes/themes.dart';
import '../../../../models/reservation_model.dart';
import '../../../resources/padding_manager.dart';
import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';
import '../controllers/restaurant_reservation_provider.dart';

class RestaurantReservationCard extends StatelessWidget {
  const RestaurantReservationCard({
    required this.reservation,
    Key? key,
    required this.args,
  }) : super(key: key);
  final Reservation reservation;
  final RestaurantOrderArguments args;

  @override
  Widget build(BuildContext context) => Padding(
        padding: PaddingManager.p11,
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                'Are you sure you want to set this as current reservation?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (context, ref, child) => IconButton(
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
                  ),
                  IconButton(
                    onPressed: () => navigatorKey.currentState!.pop(),
                    icon: const Icon(
                      Icons.cancel,
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: Card(
            color: complementaryColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: PaddingManager.p4,
              child: Column(
                children: [
                  Text(
                    'Client name - ${reservation.name}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Reservation date - ${reservation.date}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'Number of people - ${reservation.numberOfPeople.toString()}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
