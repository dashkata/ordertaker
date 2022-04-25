import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/common_providers.dart';

final restaurantProvider = StreamProvider((ref) {
  return ref.read(databaseProvider).fetchRestaurants();
});
