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

  void seeAdditionalMessages(BuildContext context, String additionalMessage) {
    final text = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: Text(
          text.additional_messages,
          style: Theme.of(context).textTheme.headline5,
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

  Future<void> showStatusDialog(
    int orderId,
    Widget orderStatusTitle,
    Widget orderStatusContent,
    int tableId,
  ) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: orderStatusTitle,
        content: orderStatusContent,
      ),
    );
  }

  Future<void> updateOrderStatus(
    int orderId,
    int tableId,
    OrderStatus orderStatus,
    String title,
  ) async {
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

  void navigateToReservations(RestaurantOrderArguments arguments) {
    navigatorKey.currentState!.popAndPushNamed(
      Routes.restaurantReservations,
      arguments: arguments,
    );
  }
}
