import '../models/order_model.dart';
import '../models/reservation_model.dart';

abstract class OrderRepo {
  Future<void> completeOrder(
    UserOrder orders,
    String uid,
    Reservation reservation,
  );

  Stream<List<UserOrder>> fetchOrdersUser(
    Reservation reservation,
    String uid,
  );

  Stream<List<UserOrder>> fetchOrdersRestaurant(
    String tableId,
    String restaurant,
  );

  Future<void> updateOrderStatus(
    int id,
    String orderStatus,
    String tableId,
    String restaurantTitle,
  );
}
