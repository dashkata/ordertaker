import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/restaurant_info_model.dart';
import '../../../../providers/repository_providers.dart';

final restaurantInfoProvider =
    FutureProvider.family<RestaurantInformation, String>(
  (ref, restaurant) =>
      ref.read(firestoreRepositoryProvider).fetchRestaurantInfo(restaurant),
);
