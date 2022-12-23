import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_tables_controller.dart';

final restaurantTablesControllerProvider =
    StateNotifierProvider.autoDispose<RestaurantTablesController, void>(
  (ref) => RestaurantTablesController(
    reservationRepo: ref.watch(
      reservationRepositoryProvider,
    ),
  ),
);

final tablesProvider = FutureProvider.family.autoDispose<List<String>, String>(
  (
    ref,
    restaurantTitle,
  ) async =>
      await ref.read(firestoreAPIProvider).fetchTables(restaurantTitle),
);
