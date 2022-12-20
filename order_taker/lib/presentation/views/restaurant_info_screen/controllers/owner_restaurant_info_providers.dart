import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/review_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import '../../../../domain/models/restaurant_model.dart';
import 'restaurant_info_controller.dart';

final restaurantInformationProvider = FutureProvider<Restaurant>(
  (ref) async =>
      await ref.read(restaurantRepositoryProvider).fetchRestaurantInfo(
            await ref.read(restaurantRepositoryProvider).fetchRestaurantTitle(
                  ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                ),
          ),
);
final restaurantReviewsProvider = StreamProvider.family<List<Review>, String>(
  (ref, restaurantTitle) =>
      ref.watch(reviewRepositoryProvider).fetchReviews(restaurantTitle),
);
final sectionIdProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

final editProvider = StateProvider<bool>(
  (ref) => false,
);
final restaurantInfoControllerProvider =
    StateNotifierProvider<RestaurantInfoController, void>(
  (ref) => RestaurantInfoController(
    restaurantRepo: ref.read(restaurantRepositoryProvider),
    storageRepository: ref.read(storageRepositoryProvider),
  ),
);
final reviewPhotoProvider = FutureProvider.family<String?, String>(
  (ref, email) async =>
      await ref.read(storageRepositoryProvider).fetchProfilePic(email: email),
);
final descriptionControllerProvider =
    StateProvider.family<TextEditingController, String>(
  (ref, description) => TextEditingController(
    text: description,
  ),
);
final workingHoursControllerProvider =
    StateProvider.family<TextEditingController, String>(
  (ref, workingHours) => TextEditingController(
    text: workingHours,
  ),
);
final phoneNumberControllerProvider =
    StateProvider.family<TextEditingController, String>(
  (ref, phoneNumber) => TextEditingController(
    text: phoneNumber,
  ),
);
final paymentMethodsControllerProvider =
    StateProvider.family<TextEditingController, String>(
  (ref, paymentMethods) => TextEditingController(
    text: paymentMethods,
  ),
);

final websiteControllerProvider =
    StateProvider.family<TextEditingController, String>(
  (ref, website) => TextEditingController(
    text: website,
  ),
);
final locationControllerProvider =
    StateProvider.family<TextEditingController, String>(
  (ref, location) => TextEditingController(
    text: location,
  ),
);
