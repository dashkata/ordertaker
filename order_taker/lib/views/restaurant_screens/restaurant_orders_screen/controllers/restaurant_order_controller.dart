import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../../owner_screens/owner_onboarding/controllers/onboarding_providers.dart';
import '../../../project_widgets.dart';
import '../../../resources/route_manager.dart';
import '../restaurant_order_arguments.dart';

class RestaurantOrderNotifier extends StateNotifier<void> {
  RestaurantOrderNotifier({required Ref ref})
      : _ref = ref,
        super(null);
  final Ref _ref;

  void seeAdditionalMessages(BuildContext context, String additionalMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Additional messages.'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(additionalMessage),
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
                  data: (title) => SimpleDialog(
                    title: Center(
                      child: Text(
                        'Current order status: $currentStatus',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    children: [
                      NormalButtons(
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
                      NormalButtons(
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
                  error: (e, s) => Text(
                    e.toString(),
                  ),
                  loading: LoadingIndicator.new,
                ),
      ),
    );
  }

  void navigateToTables() {
    navigatorKey.currentState!.popAndPushNamed(Routes.restaurantTables);
  }

  void navigateToReservations(RestaurantOrderArguments arguments) {
    navigatorKey.currentState!.pushNamed(
      Routes.restaurantReservations,
      arguments: arguments,
    );
  }
}
