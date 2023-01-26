import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/domain/repositories/menu_repo.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';

import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';

class RestaurantMenuViewModel extends StateNotifier<void> {
  RestaurantMenuViewModel({
    required RestaurantRepo restaurantRepo,
    required MenuRepo menuRepo,
    required AuthRepository authRepository,
  })  : _restaurantRepo = restaurantRepo,
        _menuRepo = menuRepo,
        _authRepository = authRepository,
        super(null);

  final RestaurantRepo _restaurantRepo;
  final MenuRepo _menuRepo;
  final AuthRepository _authRepository;

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
    final restaurantTitle = await _restaurantRepo.fetchRestaurantTitle(
      _authRepository.getCurrentUser()!.uid,
    );
    await _menuRepo.changeMenuItemStatus(
      status: status,
      restaurantTitle: restaurantTitle,
      item: item,
    );
  }

  Future<void> removeMenuItem({required OrderItem item}) async {
    final restaurantTitle = await _restaurantRepo.fetchRestaurantTitle(
      _authRepository.getCurrentUser()!.uid,
    );
    await _menuRepo.removeMenuItem(
      restaurantTitle: restaurantTitle,
      item: item,
    );
  }
}
