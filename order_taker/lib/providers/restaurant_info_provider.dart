import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/restaurant_info_model.dart';
import 'package:order_taker/providers/common_providers.dart';

final restaurantInfoProvider =
    FutureProvider.family<RestaurantInformation, String>((ref, restaurant) {
  return ref.read(databaseProvider).fetchRestaurantInfo(restaurant);
});
