import 'menu_item_model.dart';

class Order {
  final int id;
  final String status;
  final List<OrderItem> menuItems;

  Order({
    required this.id,
    required this.status,
    required this.menuItems,
  });

  List<Map<String, dynamic>> ordersToList() {
    final List<Map<String, dynamic>> orderList = [];
    for (var menuItem in menuItems) {
      orderList.add(menuItem.orderItemToMap());
    }
    return orderList;
  }

  factory Order.fromMap(List<dynamic> menuItems, int id, String status) {
    final List<OrderItem> parsedItems = [];
    for (final menuItem in menuItems) {
      parsedItems.add(OrderItem.fromMap(menuItem));
    }
    return Order(
      id: id,
      status: status,
      menuItems: parsedItems,
    );
  }
}
