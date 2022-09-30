import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboarding_controller.dart';

final itemTypeProvider = StateProvider<String>((ref) => '');
final itemTitleProvider = StateProvider<String>((ref) => '');
final itemIngredientsProvider = StateProvider<String>((ref) => '');
final itemPriceProvider = StateProvider<String>((ref) => '');
final onboardingControllerProvider =
    StateNotifierProvider<OnboardingNotifier, void>(
  (ref) => OnboardingNotifier(ref: ref),
);
