import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/models/order_model.dart';
<<<<<<< HEAD
import 'package:order_taker/models/reservation_model.dart';
=======
>>>>>>> c587147dffd54cd4c3bb6465f84747fd6ca5339f

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

<<<<<<< HEAD
  void completeOrder(Reservation reservation) {
    ref.read(firestoreRepositoryProvider).completeOrder(
=======
  void completeOrder() {
    ref.read(firestoreRepositoryProvider).completeOrder(
          'Pizza Don Vito',
          '1',
>>>>>>> c587147dffd54cd4c3bb6465f84747fd6ca5339f
          Order(
            id: 1,
            menuItems: state,
          ),
<<<<<<< HEAD
          ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
          reservation,
=======
>>>>>>> c587147dffd54cd4c3bb6465f84747fd6ca5339f
        );
    state = [];
  }
}
