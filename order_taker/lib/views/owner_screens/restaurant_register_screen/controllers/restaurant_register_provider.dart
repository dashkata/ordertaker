import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'restaurant_register_controller.dart';

final restaurantRegisterFirstNameControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');

final restaurantRegisterLastNameControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');

final restaurantRegisterEmailControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');

final restaurantRegisterPasswordControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');

final restaurantRegisterPhoneControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');

final restaurantRegisterNameControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');

final restaurantRegisterProvider =
    StateNotifierProvider<RestaurantRegisterNotifier, void>(
  (ref) => RestaurantRegisterNotifier(ref: ref),
);
