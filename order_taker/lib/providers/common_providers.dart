import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services_provider.dart';

final restaurantPictureProvider = FutureProvider.autoDispose
    .family<String, String>((ref, restaurantName) async {
  final storageServices = ref.watch(storageServicesProvider);
  return await storageServices.fetchRestaurantPicture(restaurantName);
});
