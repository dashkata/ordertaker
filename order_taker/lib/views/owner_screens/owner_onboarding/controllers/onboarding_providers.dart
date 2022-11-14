import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/menu_item_model.dart';
import '../../../../models/menu_section_model.dart';
import '../../../../providers/repository_providers.dart';
import 'onboarding_controller.dart';

final itemTypeProvider = StateProvider<String>((ref) => '');
final itemTitleProvider = StateProvider<String>((ref) => '');
final itemIngredientsProvider = StateProvider<String>((ref) => '');
final itemPriceProvider = StateProvider<String>((ref) => '');
final itemImageProvider = StateProvider<String>((ref) => '');
final restaurantAddressProvider = StateProvider<String>((ref) => '');
final restaurantPaymentProvider = StateProvider<String>((ref) => '');
final restaurantHoursProvider = StateProvider<String>((ref) => '');
final restaurantDescriptionProvider = StateProvider<String>((ref) => '');
final restaurantWebsiteProvider = StateProvider<String>((ref) => '');
final restaurantPhoneNumberProvider = StateProvider<String>((ref) => '');
final restaurantTablesProvider = StateProvider<String>((ref) => '');
final restaurantPhotoProvider = StateProvider<String>((ref) => '');

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, void>(
  (ref) => OnboardingController(ref: ref),
);

