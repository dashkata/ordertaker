import 'menu_item_model.dart';

class UserOrder {
  final int id;
  final String status;
  final Map<OrderItem, int> menuItems;
  final String additionalMessage;

  UserOrder({
    required this.id,
    required this.status,
    required this.menuItems,
    required this.additionalMessage,
  });

  List<Map<String, dynamic>> ordersToList() {
    final List<Map<String, dynamic>> orderList = [];
    for (final menuItem in menuItems.keys) {
      final Map<String, dynamic> orderMap = {};
      orderMap['item'] = menuItem.orderItemToMap();
      orderMap['count'] = menuItems[menuItem];
      orderList.add(orderMap);
    }
    return orderList;
  }

  factory UserOrder.fromMap(
    List<dynamic> menuItems,
    int id,
    String status,
    String additionalMessage,
  ) {
    final Map<OrderItem, int> parsedItems = {};
    for (final menuItem in menuItems) {
      parsedItems[OrderItem.fromMap(menuItem['item'])] = menuItem['count'];
    }
    return UserOrder(
      id: id,
      status: status,
      menuItems: parsedItems,
      additionalMessage: additionalMessage,
    );
  }

  factory UserOrder.empty() => UserOrder(
        id: 0,
        status: '',
        menuItems: {},
        additionalMessage: '',
      );
}
