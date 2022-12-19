import 'menu_item_entity.dart';

class UserOrderEntity {
  final int id;
  final String status;
  final Map<OrderItemEntity, int> menuItems;
  final String additionalMessage;

  UserOrderEntity({
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

  factory UserOrderEntity.fromMap(
    List<dynamic> menuItems,
    int id,
    String status,
    String additionalMessage,
  ) {
    final Map<OrderItemEntity, int> parsedItems = {};
    for (final menuItem in menuItems) {
      parsedItems[OrderItemEntity.fromMap(menuItem['item'])] =
          menuItem['count'];
    }
    return UserOrderEntity(
      id: id,
      status: status,
      menuItems: parsedItems,
      additionalMessage: additionalMessage,
    );
  }
}
