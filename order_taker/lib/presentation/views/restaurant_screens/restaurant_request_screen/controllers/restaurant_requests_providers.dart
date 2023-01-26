import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_requests_viewmodel.dart';

final restaurantRequestsProvider =
    StreamProvider.autoDispose.family<List<Reservation>, String>(
  (ref, restaurantTitle) => ref
      .watch(reservationRepositoryProvider)
      .fetchRestaurantRequests(restaurantTitle),
);
final tableProvider = StateProvider<int>(
  (ref) => 0,
);
final restaurantRequestViewModelProvider =
    StateNotifierProvider.autoDispose<RestaurantRequestsViewModel, void>(
  (ref) => RestaurantRequestsViewModel(
    reservationRepo: ref.read(
      reservationRepositoryProvider,
    ),
  ),
);
