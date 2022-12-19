import 'package:order_taker/data/entities/menu_item_entity.dart';
import 'package:order_taker/domain/models/menu_section_model.dart';

class MenuSectionEntity {
  final String title;
  final List<OrderItemEntity> items;

  MenuSectionEntity({
    required this.title,
    required this.items,
  });

  factory MenuSectionEntity.fromMap(Map data, String title) {
    final Map<String, dynamic> dataItems = data[title];
    final List<OrderItemEntity> parsedItems = [];
    for (final item in dataItems.keys) {
      parsedItems.add(OrderItemEntity.fromMap(dataItems[item]!));
    }
    return MenuSectionEntity(title: title, items: parsedItems);
  }

  MenuSection toMenuSection() => MenuSection(
        title: title,
        items: items.map((item) => item.toOrderItem()).toList(),
      );
}
