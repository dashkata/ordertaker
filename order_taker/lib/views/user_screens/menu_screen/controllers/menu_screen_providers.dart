import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/menu_item_model.dart';
import '../../../../models/menu_section_model.dart';
import '../../../../providers/repository_providers.dart';
import 'menu_function_notifier.dart';
import 'menu_screen_notifier.dart';

final navBarIndexProvider = StateProvider<int>((ref) => 0);
final menuFunctionsProvider =
    StateNotifierProvider<MenuFunctionsNotifier, void>(
  (ref) => MenuFunctionsNotifier(),
);
final menuCardsControllerProvider =
    StateNotifierProvider<MenuScreenNotifier, Map<OrderItem, int>>(
  MenuScreenNotifier.new,
);
final fetchMenuProvider = StreamProvider.family<List<MenuSection>, String>(
  (ref, title) => ref.watch(firestoreRepositoryProvider).fetchMenu(title),
);
final additionalMessagesProvider = StateProvider<String>((ref) => '');
