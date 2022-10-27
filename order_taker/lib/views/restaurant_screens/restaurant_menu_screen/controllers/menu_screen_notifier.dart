import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/menu_item_model.dart';
import '../../../../providers/repository_providers.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';

class RestaurantMenuController extends StateNotifier<void> {
  RestaurantMenuController({
    required StateNotifierProviderRef ref,
  })  : _ref = ref,
        super(null);
  final StateNotifierProviderRef _ref;

  Future<void> statusDialog(
    Widget title,
    Widget content,
  ) async {
    await showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (_) => CustomAlertDialog(
        title: title,
        content: content,
      ),
    );
  }

  Future<void> removeItemDialog(
    Widget title,
    Widget content,
  ) async {
    await showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (_) => CustomAlertDialog(
        title: title,
        content: content,
      ),
    );
  }

  Future<void> updateMenuItemStatus({
    required bool status,
    required OrderItem item,
  }) async {
    final restaurantTitle =
        await _ref.watch(firestoreRepositoryProvider).fetchRestaurantTitle(
              _ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
            );
    await _ref.watch(firestoreRepositoryProvider).changeMenuItemStatus(
          status: status,
          restaurantTitle: restaurantTitle,
          item: item,
        );
  }

  Future<void> removeMenuItem({required OrderItem item}) async {
    final restaurantTitle =
        await _ref.watch(firestoreRepositoryProvider).fetchRestaurantTitle(
              _ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
            );
    await _ref.watch(firestoreRepositoryProvider).removeMenuItem(
          restaurantTitle: restaurantTitle,
          item: item,
        );
  }
}
