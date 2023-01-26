import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/domain/models/menu_section_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'menu_screen_notifier.dart';
import 'user_menu_viewmodel.dart';

final navBarIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final menuViewModelProvider =
    StateNotifierProvider.autoDispose<UserMenuViewModel, void>(
  (ref) => UserMenuViewModel(),
);
final menuOrderStateProvider = StateNotifierProvider.autoDispose<
    MenuOrderStateNotifier, Map<OrderItem, int>>(
  MenuOrderStateNotifier.new,
);
final menuListProvider =
    StreamProvider.family.autoDispose<List<MenuSection>, String>(
  (ref, title) => ref.watch(menuRepositoryProvider).fetchMenu(title),
);
final additionalMessagesProvider = StateProvider<String>((ref) => '');
