import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/repository_providers.dart';

final restaurantPictureProvider = FutureProvider.autoDispose
    .family<String?, String>((ref, restaurantName) async {
  final _storage = ref.watch(storageRepositoryProvider);
  return await _storage.fetchRestaurantPic(restaurantName: restaurantName);
});
