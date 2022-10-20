import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/reservation_model.dart';
import '../../../resources/padding_manager.dart';
import '../../../resources/route_manager.dart';

class MenuFunctionsNotifier extends StateNotifier<void> {
  MenuFunctionsNotifier() : super(null);

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
        child: AlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      ),
    );
  }

  void navigateToBill(Reservation reservation) {
    navigatorKey.currentState!.popAndPushNamed(
      Routes.userBill,
      arguments: reservation,
    );
  }
}
