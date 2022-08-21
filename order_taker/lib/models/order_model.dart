import 'menu_item_model.dart';

class Order {
  final int id;
  final List<MenuItem> menuItems;

  Order({required this.id, required this.menuItems});
}
