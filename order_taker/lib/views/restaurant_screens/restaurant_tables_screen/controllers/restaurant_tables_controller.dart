import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../resources/route_manager.dart';
import '../../restaurant_orders_screen/restaurant_order_arguments.dart';

class RestaurantTablesNotifier extends StateNotifier<void> {
  RestaurantTablesNotifier() : super(null);

  void navigateToOrders(int tableId) {
    navigatorKey.currentState!.pushNamed(
      Routes.restaurantOrders,
      arguments: RestaurantOrderArguments(
        id: tableId,
        restaurantTitle: 'Pizza Don Vito',
      ),
    );
  }
}
