import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/menu_item_model.dart';
import 'menu_function_notifier.dart';
import 'menu_screen_notifier.dart';

final navBarIndexProvider = StateProvider<int>((ref) => 0);
final menuFunctionsProvider =
    StateNotifierProvider<MenuFunctionsNotifier, void>(
  (ref) => MenuFunctionsNotifier(),
);
final menuCardsControllerProvider =
    StateNotifierProvider<MenuScreenNotifier, List<OrderItem>>(
  MenuScreenNotifier.new,
);
