import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_viewmodel.dart';

final restaurantListProvider = StreamProvider.autoDispose<List<Restaurant>>(
  (ref) => ref.watch(restaurantRepositoryProvider).fetchRestaurants(),
);
final restaurantViewModelProvider =
    StateNotifierProvider.autoDispose<RestaurantScreenViewModel, void>(
  (ref) => RestaurantScreenViewModel(),
);

final userDateProvider = StateProvider.autoDispose<String>((ref) => '');

final peopleProvider = StateProvider<int>((ref) => 0);
final preferredLocationProvider = StateProvider.autoDispose<int>((ref) => 0);
