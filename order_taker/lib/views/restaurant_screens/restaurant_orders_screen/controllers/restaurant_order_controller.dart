import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/common_providers.dart';
import '../../../../providers/repository_providers.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_progress_indicator.dart';
import '../../../resources/route_manager.dart';
import '../restaurant_order_arguments.dart';

class RestaurantOrderController extends StateNotifier<void> {
  RestaurantOrderController({required Ref ref})
      : _ref = ref,
        super(null);
  final Ref _ref;

  void seeAdditionalMessages(BuildContext context, String additionalMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: Text(
          'Additional messages',
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

  Future<void> setStatus(
    int orderId,
    String currentStatus,
    int tableId,
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => Consumer(
        builder: (context, ref, child) =>
            _ref.watch(restaurantTitleProvider).when(
                  data: (title) => CustomAlertDialog(
                    title: Column(
                      children: [
                        Center(
                          child: Text(
                            'Set order status',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Current status: $currentStatus',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          buttonText: 'In progress',
                          buttonFunc: () async {
                            await _ref
                                .read(firestoreRepositoryProvider)
                                .updateOrderStatus(
                                  orderId,
                                  'In progress',
                                  tableId.toString(),
                                  title,
                                );

                            navigatorKey.currentState!.pop();
                          },
                        ),
                        CustomButton(
                          buttonText: 'Completed',
                          buttonFunc: () async {
                            await _ref
                                .read(firestoreRepositoryProvider)
                                .updateOrderStatus(
                                  orderId,
                                  'Completed',
                                  tableId.toString(),
                                  title,
                                );
                            navigatorKey.currentState!.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  error: (e, s) => Text(
                    e.toString(),
                  ),
                  loading: CustomProgressIndicator.new,
                ),
      ),
    );
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
