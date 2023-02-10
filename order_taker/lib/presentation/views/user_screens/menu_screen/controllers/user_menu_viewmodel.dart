import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';

import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/padding_manager.dart';
import '../../../resources/route_manager.dart';

class UserMenuViewModel extends StateNotifier<void> {
  UserMenuViewModel() : super(null);

  Future<void> showOrderFABDialog({
    required Widget content,
    required List<Widget> actions,
    required Widget title,
  }) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (context) => Padding(
        padding: PaddingManager.p8,
        child: CustomAlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      ),
    );
  }

  void navigateToReservation() =>
      navigatorKey.currentState!.pushReplacementNamed(
        Routes.userReservations,
      );

  void navigateToBill(Reservation reservation) {
    navigatorKey.currentState!.pushReplacementNamed(
      Routes.userBill,
      arguments: reservation,
    );
  }
}
