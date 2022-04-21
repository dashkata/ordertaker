import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/services/firestore_services.dart';

final databaseProvider = Provider<DatabaseService>((ref) => DatabaseService());

final restaurantProvider = FutureProvider((ref) async {
  return ref.read(databaseProvider).fetchRestaurants();
});
