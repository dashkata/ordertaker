import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/services/storage_services.dart';

class StorageStateNotifier extends StateNotifier<AsyncValue<String>> {
  StorageStateNotifier(this._storageServices)
      : super(const AsyncData<String>(''));
  final StorageServices _storageServices;

  Future<void> uploadProfilePicture(File photoFile) async {
    state = const AsyncLoading<String>();
    state = await AsyncValue.guard<String>(
        () => _storageServices.uploadProfilePicture(photoFile));
  }

  Future<void> fetchRestaurantPicture(String restaurantName) async {
    state = const AsyncLoading<String>();
    state = await AsyncValue.guard<String>(
        () => _storageServices.fetchRestaurantPicture(restaurantName));
  }
}
