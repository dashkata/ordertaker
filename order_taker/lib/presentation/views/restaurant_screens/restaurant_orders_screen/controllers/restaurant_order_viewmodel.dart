import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/repositories/order_repo.dart';
import 'package:order_taker/enums/order_status.dart';

import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';
import '../restaurant_order_arguments.dart';

class RestaurantOrderViewModel extends StateNotifier<void> {
  RestaurantOrderViewModel({required OrderRepo orderRepo})
      : _orderRepo = orderRepo,
        super(null);
  final OrderRepo _orderRepo;

  void seeAdditionalMessages({
    required String additionalMessage,
    required AppLocalizations text,
  }) {
    showDialog(
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: Center(
          child: Text(
            text.additional_messages,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              additionalMessage,
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showStatusDialog({
    required int orderId,
    required Widget orderStatusTitle,
    required Widget orderStatusContent,
    required int tableId,
  }) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: orderStatusTitle,
        content: orderStatusContent,
      ),
    );
  }

  Future<void> updateOrderStatus({
    required int orderId,
    required int tableId,
    required OrderStatus orderStatus,
    required String title,
  }) async {
    await _orderRepo.updateOrderStatus(
      orderId,
      orderStatus.name,
      tableId.toString(),
      title,
    );

    navigatorKey.currentState!.pop();
  }

  void navigateToTables() {
    navigatorKey.currentState!.popAndPushNamed(Routes.restaurantTables);
  }

  void navigateToReservations({
    required RestaurantOrderArguments arguments,
  }) {
    navigatorKey.currentState!.popAndPushNamed(
      Routes.restaurantReservations,
      arguments: arguments,
    );
  }
}
