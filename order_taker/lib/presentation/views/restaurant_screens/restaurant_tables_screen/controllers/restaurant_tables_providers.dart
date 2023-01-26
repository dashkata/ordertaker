import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_tables_viewmodel.dart';

final restaurantTablesViewModelProvider =
    StateNotifierProvider.autoDispose<RestaurantTablesViewModel, void>(
  (ref) => RestaurantTablesViewModel(
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
      await ref.read(apiProvider).fetchTables(restaurantTitle),
);
