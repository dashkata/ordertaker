import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';

import '../../../resources/route_manager.dart';

class UserReservationViewModel extends StateNotifier<void> {
  final ReservationRepo _reservationRepo;
  final AuthRepository _authRepository;

  UserReservationViewModel({
    required ReservationRepo reservationRepo,
    required AuthRepository authRepository,
  })  : _reservationRepo = reservationRepo,
        _authRepository = authRepository,
        super(null);

  Future<void> deleteReservation({
    required Widget cancelReservationDialog,
  }) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (_) => cancelReservationDialog,
    );
  }

  Future<void> navigateToMenu({
    required Reservation reservation,
  }) async {
    if (await _reservationRepo.checkUserReservation(
      reservation,
      _authRepository.getCurrentUser()!.uid,
    )) {
      await navigatorKey.currentState!.pushReplacementNamed(
        Routes.userMenu,
        arguments: reservation,
      );
    }
  }
}
