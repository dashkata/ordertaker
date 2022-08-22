import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/models/order_model.dart';

import '../providers/repository_providers.dart';

class MenuScreenNotifier extends StateNotifier<List<OrderItem>> {
  MenuScreenNotifier(this.ref) : super([]);
  final Ref ref;

  void addMenuCard(OrderItem orderItem) {
    state = [...state, orderItem];
  }

  void removeMenuCard(OrderItem orderItem) {
    state = [
      for (final card in state)
        if (card != orderItem) card,
    ];
  }

  void completeOrder() {
    ref.read(firestoreRepositoryProvider).completeOrder(
          'Pizza Don Vito',
          '1',
          Order(
            id: 1,
            menuItems: state,
          ),
        );
    state = [];
  }
}
