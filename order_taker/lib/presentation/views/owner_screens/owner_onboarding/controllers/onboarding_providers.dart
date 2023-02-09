import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'onboarding_viewmodel.dart';

final itemTypeProvider = StateProvider.autoDispose<String>((ref) => '');
final itemTitleProvider = StateProvider.autoDispose<String>((ref) => '');
final itemIngredientsProvider = StateProvider.autoDispose<String>((ref) => '');
final itemPriceProvider = StateProvider.autoDispose<String>((ref) => '');
final itemImageProvider = StateProvider.autoDispose<String>((ref) => '');
final restaurantAddressProvider = StateProvider<String>((ref) => '');
final restaurantPaymentProvider = StateProvider<String>((ref) => '');
final restaurantHoursProvider = StateProvider<String>((ref) => '');
final restaurantDescriptionProvider = StateProvider<String>((ref) => '');
final restaurantWebsiteProvider = StateProvider<String>((ref) => '');
final restaurantPhoneNumberProvider = StateProvider<String>((ref) => '');
final restaurantTablesProvider = StateProvider<String>((ref) => '');
final restaurantPhotoProvider = StateProvider<String>((ref) => '');
final currencyProvider = StateProvider.autoDispose<String>(
    (ref) => ref.read(onBoardingViewModelProvider.notifier).dropDownItems[0]);

final onBoardingViewModelProvider =
    StateNotifierProvider.autoDispose<OnBoardingViewModel, void>(
  (ref) => OnBoardingViewModel(
    authRepository: ref.read(authRepositoryProvider),
    storageRepository: ref.read(storageRepositoryProvider),
    restaurantRepo: ref.read(restaurantRepositoryProvider),
    userRepo: ref.read(userRepositoryProvider),
    menuRepo: ref.read(menuRepositoryProvider),
  ),
);
