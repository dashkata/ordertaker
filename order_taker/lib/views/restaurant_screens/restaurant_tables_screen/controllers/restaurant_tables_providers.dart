import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/restaurant_screens/restaurant_tables_screen/controllers/restaurant_tables_controller.dart';

import '../../../../providers/repository_providers.dart';

final restaurantTablesNotifierProvider =
    StateNotifierProvider<RestaurantTablesNotifier, void>(
  (ref) => RestaurantTablesNotifier(
    firestoreRepository: ref.watch(
      firestoreRepositoryProvider,
    ),
  ),
);
final fetchRestaurantTitleProvider = FutureProvider<String>(
  (ref) async =>
      await ref.read(firestoreRepositoryProvider).fetchEmployeeRestaurantTitle(
            ref.read(authRepositoryProvider).getCurrentUser()!.uid,
          ),
);

final tablesProvider = FutureProvider.family<List<String>, String>(
  (
    ref,
    restaurantTitle,
  ) async =>
      await ref.read(firestoreRepositoryProvider).fetchTables(restaurantTitle),
);
