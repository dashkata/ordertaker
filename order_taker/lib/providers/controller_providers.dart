import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/controllers/menu_screen_state_controller.dart';
import 'package:order_taker/controllers/restaurant_screen_state_controller.dart';
import 'package:order_taker/controllers/storage_state_notifier.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/providers/services_provider.dart';
import 'package:order_taker/views/user_screens/register_screen/controllers/user_register_controller.dart';

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

final userRegisterProvider =
    StateNotifierProvider<UserRegisterScreenNotifier, void>(
  (ref) => UserRegisterScreenNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
  ),
);
