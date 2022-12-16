import 'menu_item_model.dart';

class MenuSection {
  final String title;
  final List<OrderItem> items;

  MenuSection({
    required this.title,
    required this.items,
  });

  factory MenuSection.fromMap(Map data, String title) {
    final Map<String, dynamic> dataItems = data[title];
    final List<OrderItem> parsedItems = [];
    for (final item in dataItems.keys) {
      parsedItems.add(OrderItem.fromMap(dataItems[item]!));
    }
    return MenuSection(title: title, items: parsedItems);
  }
}
