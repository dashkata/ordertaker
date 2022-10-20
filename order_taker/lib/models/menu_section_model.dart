import 'menu_item_model.dart';

class MenuSection {
  final String title;
  final List<OrderItem> items;

  MenuSection({
    required this.title,
    required this.items,
  });

  factory MenuSection.fromMap(Map data, String title) {
    final dataItems = data[title];
    final List<OrderItem> parsedItems = [];
    for (final item in dataItems) {
      parsedItems.add(OrderItem.fromMap(item));
    }
    return MenuSection(title: title, items: parsedItems);
  }
}
