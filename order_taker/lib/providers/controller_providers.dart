import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/controllers/storage_state_notifier.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/providers/services_provider.dart';
import 'package:order_taker/views/login_screen/controllers/login_state_controller.dart';
import 'package:order_taker/views/user_screens/confirm_reservation_screen/controllers/user_confirm_reservation_controller.dart';
import 'package:order_taker/views/user_screens/menu_screen/controllers/menu_function_notifier.dart';
import 'package:order_taker/views/user_screens/menu_screen/controllers/menu_screen_notifier.dart';
import 'package:order_taker/views/user_screens/profile_screen/controllers/user_profile_controller.dart';
import 'package:order_taker/views/user_screens/register_screen/controllers/user_register_controller.dart';
import 'package:order_taker/views/user_screens/reservations_screen/controllers/user_reservation_state.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/controllers/restaurant_state_controller.dart';

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

final menuFunctionsProvider = StateNotifierProvider<MenuFunctionsNotifier, void>(
    (ref) => MenuFunctionsNotifier());

final userRegisterProvider =
    StateNotifierProvider<UserRegisterScreenNotifier, void>(
  (ref) => UserRegisterScreenNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
  ),
);

final userReservationProvider =
    StateNotifierProvider<UserReservationStateNotifier, void>(
  (ref) => UserReservationStateNotifier(
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, void>(
  (ref) => UserProfileNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    firestoreRepository: ref.watch(
      firestoreRepositoryProvider,
    ),
    storageRepository: ref.watch(
      storageRepositoryProvider,
    ),
  ),
);
final userConfirmReservationProvider =
    StateNotifierProvider<UserConfirmReservationNotifier, void>(
  (ref) => UserConfirmReservationNotifier(
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
final loginStateProvider = StateNotifierProvider<LoginStateNotifier, void>(
  (ref) => LoginStateNotifier(
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
