import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';
import 'package:order_taker/enums/request_status.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_error_alert_dialog.dart';

import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';

class RestaurantRequestsViewModel extends StateNotifier<void> {
  RestaurantRequestsViewModel({required ReservationRepo reservationRepo})
      : _reservationRepo = reservationRepo,
        super(null);
  final ReservationRepo _reservationRepo;

  Future<void> requestStats({
    required RequestStatus requestStatus,
    required Reservation reservation,
  }) async {
    switch (requestStatus) {
      case RequestStatus.approved:
        if (reservation.table != null) {
          final check = await _reservationRepo.checkReservationOverlap(
            reservation.restaurant.title,
            reservation.table!,
            reservation.date,
          );
          if (check) {
            await _reservationRepo.addApprovedReservation(reservation);
          } else {
            await showDialog(
              context: navigatorKey.currentState!.context,
              builder: (_) => const ErrorAlertDialog(
                errorMessage:
                    'The table you have selected already has a reservation on the current date',
              ),
            );
          }
        }

        break;
      case RequestStatus.disapproved:
        await _reservationRepo.disapproveRequest(reservation);
        break;
    }
  }

  Future<void> setTableDialog({
    required Widget title,
    required Widget content,
    required List<Widget> actions,
  }) async {
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
