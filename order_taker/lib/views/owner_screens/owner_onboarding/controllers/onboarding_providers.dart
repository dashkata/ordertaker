import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/menu_item_model.dart';
import '../../../../models/menu_section_model.dart';
import '../../../../providers/repository_providers.dart';
import 'onboarding_controller.dart';

final itemTypeProvider = StateProvider<String>((ref) => '');
final itemTitleProvider = StateProvider<String>((ref) => '');
final itemIngredientsProvider = StateProvider<String>((ref) => '');
final itemPriceProvider = StateProvider<String>((ref) => '');
final onboardingControllerProvider =
    StateNotifierProvider<OnboardingNotifier, void>(
  (ref) => OnboardingNotifier(ref: ref),
);
final fetchMenuProvider = StreamProvider<List<MenuSection>>(
  (ref) {
    print('helllo');
    return ref.watch(firestoreRepositoryProvider).fetchMenu();
  },
);
