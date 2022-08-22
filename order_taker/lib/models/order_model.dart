import 'menu_item_model.dart';

class Order {
  final int id;
  final List<OrderItem> menuItems;

  Order({
    required this.id,
    required this.menuItems,
  });
  List<Map<String, dynamic>> ordersToList() {
    List<Map<String, dynamic>> orderList = [];
    for (var menuItem in menuItems) {
      orderList.add(menuItem.orderItemToMap());
    }
    return orderList;
  }
}
