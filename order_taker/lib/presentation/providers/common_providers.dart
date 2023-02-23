import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/menu_section_model.dart';
import 'package:order_taker/presentation/providers/auth_provider.dart';

import 'repository_providers.dart';

final restaurantPictureProvider =
    FutureProvider.autoDispose.family<String, String>(
  (ref, restaurantName) async => await ref
      .read(storageRepositoryProvider)
      .fetchRestaurantPic(restaurantName: restaurantName),
);
final menuProvider = StreamProvider.family<List<MenuSection>, String>(
  (ref, restaurantTitle) => ref.watch(menuRepositoryProvider).fetchMenu(
        restaurantTitle,
      ),
);
final restaurantTitleProvider = FutureProvider<String>(
  (ref) async => ref.watch(restaurantRepositoryProvider).fetchRestaurantTitle(
        ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);
final userTypeProvider = StateProvider.autoDispose<String>((ref) {
  final asyncType = ref.watch(futureUserTypeProvider);
  return asyncType.when(
    data: (type) => type,
    error: (e, s) => 'Error',
    loading: () => 'Loading',
  );
});
