import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';

import '../../../../../domain/repositories/reservation_repo.dart';
import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';

class RestaurantReservationsViewModel extends StateNotifier<void> {
  RestaurantReservationsViewModel({
    required ReservationRepo reservationRepo,
  })  : _reservationRepo = reservationRepo,
        super(null);
  final ReservationRepo _reservationRepo;

  Future<void> setCurrentReservation({
    required Reservation reservation,
    required RestaurantOrderArguments restaurantOrderArguments,
  }) async {
    await _reservationRepo.setCurrentReservation(
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
