import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/controllers/reservations_screen_state_controller.dart';
import 'package:order_taker/controllers/restaurant_screen_state_controller.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/views/user_screens/reservations_screen/reservation_state.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/restaurant_state.dart';

final restaurantNotifierProvider =
StateNotifierProvider<RestaurantStateNotifier, RestaurantState>((ref) {
  return RestaurantStateNotifier(ref.watch(firestoreRepositoryProvider));
});
final restaurantDialogNotifierProvider =
StateNotifierProvider<RestaurantDialogNotifier, void>((ref) {
  return RestaurantDialogNotifier();
});
final reservationStateNotifierProvider = StateNotifierProvider<
    ReservationStateNotifier,
    ReservationState>((ref) {
  return ReservationStateNotifier(ref);
});
