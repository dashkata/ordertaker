import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/repository_providers.dart';

class StorageServices {
  StorageServices(this.ref);

  final Ref ref;

  Future<String> uploadProfilePicture(File photoFile) async =>
      await ref.read(storageRepositoryProvider).uploadProfilePic(
            photoFile: photoFile,
            email: ref.read(authRepositoryProvider).getCurrentUser()!.email!,
          );

  Future<String> fetchRestaurantPicture(String restaurantName) async =>
      await ref
          .read(storageRepositoryProvider)
          .fetchRestaurantPic(restaurantName: restaurantName);
}
