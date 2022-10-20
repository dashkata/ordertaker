import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/menu_item_model.dart';
import '../../../../models/order_model.dart';
import '../../../../models/reservation_model.dart';
import '../../../../providers/repository_providers.dart';
import '../../../resources/route_manager.dart';
import 'menu_screen_providers.dart';

class MenuScreenNotifier extends StateNotifier<Map<OrderItem, int>> {
  MenuScreenNotifier(this.ref) : super({});
  final Ref ref;

  void addMenuCard(OrderItem orderItem) {
    bool check = false;
    if (state.keys.isNotEmpty) {
      for (final item in state.keys) {
        if (item == orderItem) {
          state = {
            for (final value in state.keys)
              if (value == item)
                value: state[value] = state[value]! + 1
              else
                value: state[value]!
          };
          check = true;
        }
      }
      if (!check) {
        state = {
          ...state,
          ...{orderItem: 1},
        };
      }
    } else {
      state = {
        ...state,
        ...{orderItem: 1},
      };
    }
  }

  void removeMenuCard(OrderItem orderItem) {
    for (final item in state.keys) {
      if (item == orderItem) {
        if (state[item] == 1) {
          state = {
            for (final value in state.keys)
              if (value != item) value: state[value]!
          };
        } else {
          state = {
            for (final value in state.keys)
              if (value == item)
                value: state[value] = state[value]! - 1
              else
                value: state[value]!
          };
        }
      }
    }
  }

  void completeOrder(Reservation reservation) {
    ref.read(firestoreRepositoryProvider).completeOrder(
          Order(
            menuItems: state,
            id: 0,
            status: '',
            additionalMessage: ref.watch(additionalMessagesProvider),
          ),
          ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
          reservation,
        );
    state = {};
    navigatorKey.currentState!.pop();
  }
}
