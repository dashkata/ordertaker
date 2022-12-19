import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/domain/models/review_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'restaurant_info_controller.dart';

// final restaurantInformationProvider = FutureProvider<Restaurant>(
//   (ref) async
//       // await ref.read(firestoreAPIProvider).fetchRestaurantInfo(
//       //       await ref.read(firestoreAPIProvider).fetchRestaurantTitle(
//       //             ref.read(authRepositoryProvider).getCurrentUser()!.uid,
//       //           ),
//       //     ),
// );
final restaurantReviewsProvider = StreamProvider.family<List<Review>, String>(
  (ref, restaurantTitle) =>
      ref.watch(firestoreAPIProvider).fetchReviews(restaurantTitle),
);
final sectionIdProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

final editProvider = StateProvider<bool>(
  (ref) => false,
);
final restaurantInfoControllerProvider =
    StateNotifierProvider<RestaurantInfoController, void>(
  (ref) => RestaurantInfoController(),
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
