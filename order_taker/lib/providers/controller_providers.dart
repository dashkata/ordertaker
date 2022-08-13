import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/controllers/menu_screen_state_controller.dart';
import 'package:order_taker/controllers/reservations_screen_state_controller.dart';
import 'package:order_taker/controllers/restaurant_screen_state_controller.dart';
import 'package:order_taker/controllers/storage_state_notifier.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/providers/services_provider.dart';
import 'package:order_taker/views/user_screens/reservations_screen/reservation_state.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/restaurant_state.dart';

import '../views/user_screens/menu_screen/menu_widgets.dart';

final restaurantNotifierProvider =
    StateNotifierProvider<RestaurantStateNotifier, RestaurantState>((ref) {
  return RestaurantStateNotifier(ref.watch(firestoreRepositoryProvider));
});
final restaurantDialogNotifierProvider =
    StateNotifierProvider<RestaurantDialogNotifier, void>((ref) {
  return RestaurantDialogNotifier();
});
final reservationStateNotifierProvider =
    StateNotifierProvider<ReservationStateNotifier, ReservationState>((ref) {
  return ReservationStateNotifier(ref);
});
final storageStateNotifierProvider =
    StateNotifierProvider.autoDispose<StorageStateNotifier, AsyncValue<String>>(
        (ref) {
  return StorageStateNotifier(ref.watch(storageServicesProvider));
});
final menuCardsControllerProvider =
    StateNotifierProvider<MenuScreenNotifier, List<MenuCard>>((ref) {
  return MenuScreenNotifier();
});
