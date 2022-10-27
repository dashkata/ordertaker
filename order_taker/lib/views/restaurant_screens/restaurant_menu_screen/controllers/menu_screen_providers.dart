import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import 'menu_screen_notifier.dart';

final restaurantMenuControllerProvider =
    StateNotifierProvider<RestaurantMenuController, void>(
  (ref) => RestaurantMenuController(
    ref: ref,
  ),
);
