import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant_model.dart';
import 'confirm_reservation_providers.dart';
import 'repository_providers.dart';
import 'user_restaurant_providers.dart';

final fetchRestaurantsProvider = StreamProvider.autoDispose<List<Restaurant>>(
  (ref) => ref.watch(firestoreRepositoryProvider).fetchRestaurants(),
);
final fetchFreeTablesProvider =
    FutureProvider.family<Map<String, bool>, String>(
  (ref, restaurantTitle) async =>
      ref.watch(firestoreRepositoryProvider).fetchFreeTables(
            restaurantTitle,
            '${ref.watch(confirmDateProvider)} - ${ref.watch(confirmTimeProvider)}',
          ),
);
