import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_register_viewmodel.dart';

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

final restaurantRegisterViewModelProvider =
    StateNotifierProvider.autoDispose<RestaurantRegisterViewModel, void>(
  (ref) => RestaurantRegisterViewModel(
    authRepository: ref.read(authRepositoryProvider),
    userRepo: ref.read(userRepositoryProvider),
    restaurantRepo: ref.read(restaurantRepositoryProvider),
  ),
);
