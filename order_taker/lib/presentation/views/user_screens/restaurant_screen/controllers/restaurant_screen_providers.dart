import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_state_controller.dart';

final restaurantListProvider = StreamProvider.autoDispose<List<Restaurant>>(
  (ref) => ref.watch(restaurantRepositoryProvider).fetchRestaurants(),
);
final restaurantControllerProvider =
    StateNotifierProvider<RestaurantScreenController, void>(
  (ref) => RestaurantScreenController(),
);

final userDateProvider = StateProvider.autoDispose<String>((ref) => '');

final peopleProvider = StateProvider.autoDispose<int>((ref) => 0);
final preferredLocationProvider = StateProvider<int>((ref) => 0);
