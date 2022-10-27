import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../repositories/firestore_repository.dart';
import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';

class RestaurantReservationsController extends StateNotifier<void> {
  RestaurantReservationsController({
    required FirestoreRepository firestoreRepository,
  })  : _firestoreRepository = firestoreRepository,
        super(null);
  final FirestoreRepository _firestoreRepository;

  Future<void> setCurrentReservation(
    Reservation reservation,
    RestaurantOrderArguments restaurantOrderArguments,
  ) async {
    await _firestoreRepository.setCurrentReservation(
      restaurantOrderArguments.restaurantTitle,
      restaurantOrderArguments.id,
      reservation,
    );
    await navigatorKey.currentState!.popAndPushNamed(
      Routes.restaurantOrders,
      arguments: restaurantOrderArguments,
    );
  }
}
