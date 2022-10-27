import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/user_screens/menu_screen/controllers/user_menu_controller.dart';

import '../../../../models/menu_item_model.dart';
import '../../../../models/menu_section_model.dart';
import '../../../../providers/repository_providers.dart';
import 'menu_screen_notifier.dart';

final navBarIndexProvider = StateProvider<int>((ref) => 0);
final menuControllerProvider =
    StateNotifierProvider<UserMenuController, void>(
  (ref) => UserMenuController(),
);
final menuOrderStateProvider =
    StateNotifierProvider<MenuOrderStateNotifier, Map<OrderItem, int>>(
  MenuOrderStateNotifier.new,
);
final menuListProvider = StreamProvider.family<List<MenuSection>, String>(
  (ref, title) => ref.watch(firestoreRepositoryProvider).fetchMenu(title),
);
final additionalMessagesProvider = StateProvider<String>((ref) => '');
