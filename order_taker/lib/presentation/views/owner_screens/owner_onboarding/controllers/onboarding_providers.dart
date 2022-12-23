import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'onboarding_controller.dart';

final itemTypeProvider = StateProvider.autoDispose<String>((ref) => '');
final itemTitleProvider = StateProvider.autoDispose<String>((ref) => '');
final itemIngredientsProvider = StateProvider.autoDispose<String>((ref) => '');
final itemPriceProvider = StateProvider.autoDispose<String>((ref) => '');
final itemImageProvider = StateProvider.autoDispose<String>((ref) => '');
final restaurantAddressProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantPaymentProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantHoursProvider = StateProvider.autoDispose<String>((ref) => '');
final restaurantDescriptionProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantWebsiteProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantPhoneNumberProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantTablesProvider = StateProvider.autoDispose<String>((ref) => '');
final restaurantPhotoProvider = StateProvider.autoDispose<String>((ref) => '');

final onboardingControllerProvider =
    StateNotifierProvider.autoDispose<OnboardingController, void>(
  (ref) => OnboardingController(
    ref: ref,
    authRepository: ref.read(authRepositoryProvider),
    storageRepository: ref.read(storageRepositoryProvider),
    restaurantRepo: ref.read(restaurantRepositoryProvider),
    userRepo: ref.read(userRepositoryProvider),
    menuRepo: ref.read(menuRepositoryProvider),
  ),
);
