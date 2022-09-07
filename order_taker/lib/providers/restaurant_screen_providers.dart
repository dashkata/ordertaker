import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant_model.dart';
import 'repository_providers.dart';

final fetchRestaurantsProvider = StreamProvider.autoDispose<List<Restaurant>>(
  (ref) => ref.watch(firestoreRepositoryProvider).fetchRestaurants(),
);
