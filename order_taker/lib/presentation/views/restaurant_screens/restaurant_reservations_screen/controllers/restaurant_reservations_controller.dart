import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/repositories/review_repo.dart';

import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';

class RestaurantReservationsController extends StateNotifier<void> {
  RestaurantReservationsController({
    required ReservationRepo reservationRepo,
  })  : _reservationRepo = reservationRepo,
        super(null);
  final ReservationRepo _reservationRepo;

  Future<void> setCurrentReservation(
    Reservation reservation,
    RestaurantOrderArguments restaurantOrderArguments,
  ) async {
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
