import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'menu_screen_notifier.dart';

final restaurantMenuControllerProvider =
    StateNotifierProvider.autoDispose<RestaurantMenuController, void>(
  (ref) => RestaurantMenuController(
    restaurantRepo: ref.read(restaurantRepositoryProvider),
    menuRepo: ref.read(menuRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
  ),
);
