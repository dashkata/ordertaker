import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/services/firestore_services.dart';
import 'package:order_taker/services/storage_services.dart';

final databaseProvider = Provider<DatabaseService>((ref) => DatabaseService());
final storageProvider = Provider<StorageServices>((ref) => StorageServices());
final restaurantPictureProvider = FutureProvider.autoDispose
    .family<String?, String>((ref, restaurantName) async {
  final _storage = ref.watch(storageProvider);
  return await _storage.fetchRestaurantPic(restaurantName: restaurantName);
});
