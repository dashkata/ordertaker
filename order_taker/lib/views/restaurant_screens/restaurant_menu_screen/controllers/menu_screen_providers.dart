import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import 'menu_screen_notifier.dart';

final restaurantMenuStateNotifierProvider =
    StateNotifierProvider<RestaurantMenuNotifier, void>(
  (ref) => RestaurantMenuNotifier(
    ref: ref,
  ),
);
