import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/review_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import '../../../../domain/models/restaurant_model.dart';
import 'restaurant_info_viewmodel.dart';

final restaurantInformationViewModel = FutureProvider.autoDispose<Restaurant>(
  (ref) async =>
      await ref.read(restaurantRepositoryProvider).fetchRestaurantInfo(
            await ref.read(restaurantRepositoryProvider).fetchRestaurantTitle(
                  ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                ),
          ),
);
final restaurantReviewsProvider =
    StreamProvider.family.autoDispose<List<Review>, String>(
  (ref, restaurantTitle) =>
      ref.watch(reviewRepositoryProvider).fetchReviews(restaurantTitle),
);
final sectionIdProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

final editProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
final restaurantInfoControllerProvider =
    StateNotifierProvider.autoDispose<RestaurantInfoViewModel, void>(
  (ref) => RestaurantInfoViewModel(
    restaurantRepo: ref.read(restaurantRepositoryProvider),
  ),
);
final reviewPhotoProvider = FutureProvider.family.autoDispose<String?, String>(
  (ref, email) async =>
      await ref.read(storageRepositoryProvider).fetchProfilePic(email: email),
);
final descriptionControllerProvider =
    StateProvider.family.autoDispose<TextEditingController, String>(
  (ref, description) => TextEditingController(
    text: description,
  ),
);
final workingHoursControllerProvider =
    StateProvider.family.autoDispose<TextEditingController, String>(
  (ref, workingHours) => TextEditingController(
    text: workingHours,
  ),
);
final phoneNumberControllerProvider =
    StateProvider.family.autoDispose<TextEditingController, String>(
  (ref, phoneNumber) => TextEditingController(
    text: phoneNumber,
  ),
);
final paymentMethodsControllerProvider =
    StateProvider.family.autoDispose<TextEditingController, String>(
  (ref, paymentMethods) => TextEditingController(
    text: paymentMethods,
  ),
);

final websiteControllerProvider =
    StateProvider.family.autoDispose<TextEditingController, String>(
  (ref, website) => TextEditingController(
    text: website,
  ),
);
final locationControllerProvider =
    StateProvider.family.autoDispose<TextEditingController, String>(
  (ref, location) => TextEditingController(
    text: location,
  ),
);
