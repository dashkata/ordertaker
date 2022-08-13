import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/user_screens/menu_screen/menu_widgets.dart';

class MenuScreenNotifier extends StateNotifier<List<MenuCard>> {
  MenuScreenNotifier() : super([]);

  void addMenuCard(MenuCard menuCard) {
    state = [...state, menuCard];
  }

  void removeMenuCard(MenuCard menuCard) {
    state = [
      for (final card in state)
        if (card != menuCard) card,
    ];
  }
}
