import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/data/repositories/firestore_repository.dart';
import 'package:order_taker/domain/models/reservation_model.dart';

import '../../../resources/route_manager.dart';

class UserConfirmReservationController extends StateNotifier<void> {
  UserConfirmReservationController({
    required FirestoreRepository firestoreRepository,
    required AuthRepository authRepository,
  })  : _firestoreRepository = firestoreRepository,
        _authRepository = authRepository,
        super(null);
  final FirestoreRepository _firestoreRepository;
  final AuthRepository _authRepository;

  void addReservation(Reservation reservation) {
    _firestoreRepository.addReservation(
      _authRepository.getCurrentUser()!.uid,
      reservation,
    );
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      Routes.userReservations,
      (Route<dynamic> route) => false,
    );
  }
}
