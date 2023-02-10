import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';

import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';

class RestaurantTablesViewModel extends StateNotifier<void> {
  RestaurantTablesViewModel({
    required ReservationRepo reservationRepo,
  })  : _reservationRepo = reservationRepo,
        super(null);
  final ReservationRepo _reservationRepo;

  Future<void> navigateToOrders({
    required int tableId,
    required String restaurantTitle,
  }) async {
    final currentRes = await _reservationRepo.checkForCurrentReservation(
      restaurantTitle,
      tableId,
    );
    if (currentRes) {
      await navigatorKey.currentState!.pushNamed(
        Routes.restaurantReservations,
        arguments: RestaurantOrderArguments(
          id: tableId,
          restaurantTitle: restaurantTitle,
        ),
      );
    } else {
      await navigatorKey.currentState!.pushNamed(
        Routes.restaurantOrders,
        arguments: RestaurantOrderArguments(
          id: tableId,
          restaurantTitle: restaurantTitle,
        ),
      );
    }
  }
}
