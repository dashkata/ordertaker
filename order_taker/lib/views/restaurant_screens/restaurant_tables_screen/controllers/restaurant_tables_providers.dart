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
