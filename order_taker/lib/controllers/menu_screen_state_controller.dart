import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/models/order_model.dart';
import 'package:order_taker/models/reservation_model.dart';

import '../Themes/themes.dart';
import '../providers/repository_providers.dart';
import '../views/resources/padding_manager.dart';
import '../views/resources/string_manager.dart';
import '../views/resources/style_manager.dart';

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

  void completeOrder(Reservation reservation) {
    ref.read(firestoreRepositoryProvider).completeOrder(
          Order(
            menuItems: state,
          ),
          ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
          reservation,
        );
    state = [];
  }
}

class MenuFunctionsNotifier extends StateNotifier<void> {
  MenuFunctionsNotifier() : super(null);

  Future<void> showOrderFABDialog(
    Widget content,
    List<Widget> actions,
    Widget title,
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: PaddingManager.p8,
          child: AlertDialog(
            title: title,
            content: content,
            actions: actions,
          ),
        );
      },
    );
  }
}
