import 'package:order_taker/domain/models/menu_section_model.dart';

import '../models/menu_item_model.dart';

abstract class MenuRepo {
  Future<void> addMenuItem(OrderItem orderItem, String restaurant);

  Stream<List<MenuSection>> fetchMenu(String title);

  Future<void> changeMenuItemStatus({
    required bool status,
    required String restaurantTitle,
    required OrderItem item,
  });

  Future<void> removeMenuItem({
    required OrderItem item,
    required String restaurantTitle,
  });
}
