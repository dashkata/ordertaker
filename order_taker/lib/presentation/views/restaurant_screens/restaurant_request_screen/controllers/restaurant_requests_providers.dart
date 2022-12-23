import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_requests_controller.dart';

final restaurantRequestsProvider =
    StreamProvider.autoDispose.family<List<Reservation>, String>(
  (ref, restaurantTitle) => ref
      .watch(reservationRepositoryProvider)
      .fetchRestaurantRequests(restaurantTitle),
);
final tableProvider = StateProvider<int>(
  (ref) => 0,
);
final restaurantRequestControllerProvider =
    StateNotifierProvider.autoDispose<RestaurantRequestsController, void>(
  (ref) => RestaurantRequestsController(
    reservationRepo: ref.read(
      reservationRepositoryProvider,
    ),
  ),
);
