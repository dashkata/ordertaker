import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/services_provider.dart';

final restaurantPictureProvider = FutureProvider.autoDispose
    .family<String, String>((ref, restaurantName) async {
  final _storageServices = ref.watch(storageServicesProvider);
  return await _storageServices.fetchRestaurantPicture(restaurantName);
});
