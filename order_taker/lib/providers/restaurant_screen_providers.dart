import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/restaurant_model.dart';
import 'package:order_taker/providers/repository_providers.dart';

final fetchRestaurantsProvider =
    StreamProvider.autoDispose<List<Restaurant>>((ref) {
  return ref.watch(firestoreRepositoryProvider).fetchRestaurants();
});
