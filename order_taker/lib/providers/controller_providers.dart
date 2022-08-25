import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/controllers/menu_screen_state_controller.dart';
import 'package:order_taker/controllers/restaurant_screen_state_controller.dart';
import 'package:order_taker/controllers/storage_state_notifier.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/providers/services_provider.dart';

final restaurantDialogNotifierProvider =
    StateNotifierProvider<RestaurantDialogNotifier, void>((ref) {
  return RestaurantDialogNotifier();
});

final storageStateNotifierProvider =
    StateNotifierProvider.autoDispose<StorageStateNotifier, AsyncValue<String>>(
        (ref) {
  return StorageStateNotifier(ref.watch(storageServicesProvider));
});
final menuCardsControllerProvider =
    StateNotifierProvider<MenuScreenNotifier, List<OrderItem>>((ref) {
  return MenuScreenNotifier(ref);
});

final menuDialogProvider = StateNotifierProvider<MenuFunctionsNotifier, void>(
    (ref) => MenuFunctionsNotifier());
