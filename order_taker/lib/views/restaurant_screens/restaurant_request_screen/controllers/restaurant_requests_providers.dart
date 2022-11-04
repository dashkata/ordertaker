import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../providers/repository_providers.dart';
import 'restaurant_requests_controller.dart';

final restaurantRequestsProvider =
    StreamProvider.autoDispose.family<List<Reservation>, String>(
  (ref, restaurantTitle) => ref
      .watch(firestoreRepositoryProvider)
      .fetchRestaurantRequests(restaurantTitle),
);
final tableProvider = StateProvider<int>(
  (ref) => 0,
);
final restaurantRequestControllerProvider =
    StateNotifierProvider<RestaurantRequestsController, void>(
  (ref) => RestaurantRequestsController(),
);
