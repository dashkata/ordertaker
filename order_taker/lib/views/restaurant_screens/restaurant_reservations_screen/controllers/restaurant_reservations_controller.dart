import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../repositories/firestore_repository.dart';

class RestaurantReservationsNotifier extends StateNotifier<void> {
  RestaurantReservationsNotifier({
    required FirestoreRepository firestoreRepository,
  })  : _firestoreRepository = firestoreRepository,
        super(null);
  final FirestoreRepository _firestoreRepository;

  Future<void> setCurrentReservation(
    Reservation reservation,
    String restaurantTitle,
    int tableId,
  ) async {
    await _firestoreRepository.setCurrentReservation(
      restaurantTitle,
      tableId,
      reservation,
    );

  }
}
