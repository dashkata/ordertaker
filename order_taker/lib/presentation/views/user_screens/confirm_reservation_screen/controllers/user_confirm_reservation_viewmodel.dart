import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/domain/models/reservation_model.dart';

import '../../../../../domain/repositories/reservation_repo.dart';
import '../../../resources/route_manager.dart';

class UserConfirmReservationViewModel extends StateNotifier<void> {
  UserConfirmReservationViewModel({
    required ReservationRepo reservationRepo,
    required AuthRepository authRepository,
  })  : _reservationRepo = reservationRepo,
        _authRepository = authRepository,
        super(null);
  final ReservationRepo _reservationRepo;
  final AuthRepository _authRepository;

  void addReservation({required Reservation reservation}) {
    _reservationRepo.addReservation(
      _authRepository.getCurrentUser()!.uid,
      reservation,
    );
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      Routes.userReservations,
      (Route<dynamic> route) => false,
    );
  }
}
