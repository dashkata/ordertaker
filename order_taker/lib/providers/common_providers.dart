import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/menu_section_model.dart';
import 'repository_providers.dart';
import 'services_provider.dart';

final restaurantPictureProvider = FutureProvider.autoDispose
    .family<String, String>((ref, restaurantName) async {
  final storageServices = ref.watch(storageServicesProvider);
  return await storageServices.fetchRestaurantPicture(restaurantName);
});
final menuProvider = StreamProvider.family<List<MenuSection>, String>(
  (ref, restaurantTitle) => ref.watch(firestoreRepositoryProvider).fetchMenu(
        restaurantTitle,
      ),
);
final restaurantTitleProvider = FutureProvider<String>(
      (ref) async => ref.watch(firestoreRepositoryProvider).fetchRestaurantTitle(
    ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
  ),
);
