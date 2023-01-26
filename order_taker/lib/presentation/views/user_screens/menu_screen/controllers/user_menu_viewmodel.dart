import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';

import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/padding_manager.dart';
import '../../../resources/route_manager.dart';

class UserMenuController extends StateNotifier<void> {
  UserMenuController() : super(null);

  Future<void> showOrderFABDialog(
    Widget content,
    List<Widget> actions,
    Widget title,
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
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

  void navigateToBill(Reservation reservation) {
    navigatorKey.currentState!.pushReplacementNamed(
      Routes.userBill,
      arguments: reservation,
    );
  }
}
