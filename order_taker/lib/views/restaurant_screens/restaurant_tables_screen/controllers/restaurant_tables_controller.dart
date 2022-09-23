import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../repositories/firestore_repository.dart';
import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';

class RestaurantTablesNotifier extends StateNotifier<void> {
  RestaurantTablesNotifier({
    required FirestoreRepository firestoreRepository,
  })  : _firestoreRepository = firestoreRepository,
        super(null);
  final FirestoreRepository _firestoreRepository;

  Future<void> navigateToOrders(int tableId) async {
    final currentRes = await _firestoreRepository.checkForCurrentReservation(
      'Pizza Don Vito',
      tableId,
    );
    if (currentRes) {
      await navigatorKey.currentState!.pushNamed(
        Routes.restaurantReservations,
        arguments: RestaurantOrderArguments(
          id: tableId,
          restaurantTitle: 'Pizza Don Vito',
        ),
      );
    } else {
      await navigatorKey.currentState!.pushNamed(
        Routes.restaurantOrders,
        arguments: RestaurantOrderArguments(
          id: tableId,
          restaurantTitle: 'Pizza Don Vito',
        ),
      );
    }
  }
}
