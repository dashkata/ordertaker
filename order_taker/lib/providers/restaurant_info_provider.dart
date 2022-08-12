import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/restaurant_info_model.dart';
import 'package:order_taker/providers/repository_providers.dart';

final restaurantInfoProvider =
    FutureProvider.family<RestaurantInformation, String>((ref, restaurant) {
  return ref.read(firestoreRepositoryProvider).fetchRestaurantInfo(restaurant);
});
