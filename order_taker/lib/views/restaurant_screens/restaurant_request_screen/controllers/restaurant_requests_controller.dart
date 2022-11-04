import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../enums/request_status.dart';
import '../../../../models/reservation_model.dart';
import '../../../../providers/repository_providers.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';

class RestaurantRequestsController extends StateNotifier<void> {
  RestaurantRequestsController() : super(null);

  Future<void> requestStats(
    RequestStatus requestStatus,
    Reservation reservation,
    WidgetRef ref,
  ) async {
    switch (requestStatus) {
      case RequestStatus.approved:
        await ref
            .read(firestoreRepositoryProvider)
            .addApprovedReservation(reservation);
        break;
      case RequestStatus.disapproved:
        await ref
            .read(firestoreRepositoryProvider)
            .disapproveRequest(reservation);
        break;
    }
  }

  Future<void> setTableDialog(Widget title, Widget content, List<Widget> actions) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (_) => CustomAlertDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }
}
