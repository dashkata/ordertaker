import 'menu_item_model.dart';

class Order {
  final List<OrderItem> menuItems;

  Order({
    required this.menuItems,
  });
  List<Map<String, dynamic>> ordersToList() {
    List<Map<String, dynamic>> orderList = [];
    for (var menuItem in menuItems) {
      orderList.add(menuItem.orderItemToMap());
    }
    return orderList;
  }

  factory Order.fromMap(List<dynamic> menuItems) {
    List<OrderItem> parsedItems = [];
    for (final menuItem in menuItems) {
      parsedItems.add(OrderItem.fromMap(menuItem));
    }
    return Order(menuItems: parsedItems);
  }
}
