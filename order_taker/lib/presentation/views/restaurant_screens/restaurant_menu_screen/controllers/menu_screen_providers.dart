import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'menu_screen_viewmodel.dart';

final restaurantMenuViewModelProvider =
    StateNotifierProvider.autoDispose<RestaurantMenuViewModel, void>(
  (ref) => RestaurantMenuViewModel(
    restaurantRepo: ref.read(restaurantRepositoryProvider),
    menuRepo: ref.read(menuRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
  ),
);
