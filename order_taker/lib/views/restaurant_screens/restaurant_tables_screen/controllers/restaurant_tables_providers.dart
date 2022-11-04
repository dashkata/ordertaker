import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/restaurant_screens/restaurant_tables_screen/controllers/restaurant_tables_controller.dart';

import '../../../../providers/repository_providers.dart';

final restaurantTablesControllerProvider =
    StateNotifierProvider<RestaurantTablesController, void>(
  (ref) => RestaurantTablesController(
    firestoreRepository: ref.watch(
      firestoreRepositoryProvider,
    ),
  ),
);
final restaurantTitleProvider = FutureProvider<String>(
  (ref) async =>
      await ref.read(firestoreRepositoryProvider).fetchRestaurantTitle(
            ref.read(authRepositoryProvider).getCurrentUser()!.uid,
          ),
);

final tablesProvider = FutureProvider.family.autoDispose<List<String>, String>(
  (
    ref,
    restaurantTitle,
  ) async =>
      await ref.read(firestoreRepositoryProvider).fetchTables(restaurantTitle),
);
