import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories/firestore_repository.dart';
import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';

class RestaurantTablesController extends StateNotifier<void> {
  RestaurantTablesController({
    required FirestoreRepository firestoreRepository,
  })  : _firestoreRepository = firestoreRepository,
        super(null);
  final FirestoreRepository _firestoreRepository;

  Future<void> navigateToOrders(int tableId, String restaurantTitle) async {
    final currentRes = await _firestoreRepository.checkForCurrentReservation(
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
