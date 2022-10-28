import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../models/review_model.dart';
import '../../../../providers/repository_providers.dart';
import '../../../resources/route_manager.dart';

class BillScreenController extends StateNotifier<void> {
  BillScreenController({required StateNotifierProviderRef ref})
      : _ref = ref,
        super(null);
  final StateNotifierProviderRef _ref;

  void navigateToMenu(Reservation reservation) {
    navigatorKey.currentState!.popAndPushNamed(
      Routes.userMenu,
      arguments: reservation,
    );
  }

  Future<void> pay(
    Reservation reservation,
    String reviewMessage,
    double reviewRating,
  ) async {
    if (reviewMessage.isNotEmpty && reviewRating != 0) {
      await _ref.read(firestoreRepositoryProvider).addRestaurantReview(
            reservation.restaurant,
            Review(
              name: reservation.name,
              review: reviewMessage,
              rating: reviewRating,
            ),
          );
    }
    await _ref.read(firestoreRepositoryProvider).deleteReservation(
          _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
          reservation,
        );
    await navigatorKey.currentState!.popAndPushNamed(Routes.userRestaurants);
  }
}
