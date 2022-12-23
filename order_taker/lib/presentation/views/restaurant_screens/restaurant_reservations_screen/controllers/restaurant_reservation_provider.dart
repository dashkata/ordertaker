import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';

import '../../../../providers/repository_providers.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';
import 'restaurant_reservations_controller.dart';

final restaurantReservationsProvider = StreamProvider.family
    .autoDispose<List<Reservation>, RestaurantOrderArguments>(
  (ref, args) => ref
      .watch(reservationRepositoryProvider)
      .fetchRestaurantReservations(args.restaurantTitle, args.id),
);

final restaurantReservationsControllerProvider =
    StateNotifierProvider.autoDispose<RestaurantReservationsController, void>(
  (ref) => RestaurantReservationsController(
    reservationRepo: ref.watch(reservationRepositoryProvider),
  ),
);
