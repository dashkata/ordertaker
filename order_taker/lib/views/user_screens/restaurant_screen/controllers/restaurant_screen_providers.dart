import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/restaurant_model.dart';
import '../../../../providers/repository_providers.dart';
import '../../confirm_reservation_screen/controllers/confirm_reservation_providers.dart';
import 'restaurant_state_controller.dart';

final restaurantListProvider = StreamProvider.autoDispose<List<Restaurant>>(
  (ref) => ref.watch(firestoreRepositoryProvider).fetchRestaurants(),
);
final freeTableListProvider = FutureProvider.family<Map<String, bool>, String>(
  (ref, restaurantTitle) async =>
      ref.watch(firestoreRepositoryProvider).fetchFreeTables(
            restaurantTitle,
            '${ref.watch(confirmDateProvider)} '
            '- ${ref.watch(confirmTimeProvider)}',
          ),
);
final restaurantControllerProvider =
    StateNotifierProvider<RestaurantScreenController, void>(
  (ref) => RestaurantScreenController(),
);

final userDateProvider = StateProvider.autoDispose<String>((ref) => '');

final peopleProvider = StateProvider.autoDispose<int>((ref) => 0);
final preferredLocationProvider = StateProvider<int>((ref) => 0);
