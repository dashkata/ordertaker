import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/repositories/auth_repository.dart';
import 'package:order_taker/repositories/firestore_repository.dart';
import 'package:order_taker/views/resources/route_manager.dart';

class UserConfirmReservationNotifier extends StateNotifier<void> {
  UserConfirmReservationNotifier(
      {required FirestoreRepository firestoreRepository,
      required AuthRepository authRepository})
      : _firestoreRepository = firestoreRepository,
        _authRepository = authRepository,
        super(null);
  final FirestoreRepository _firestoreRepository;
  final AuthRepository _authRepository;

  void addReservation(Reservation reservation) {
    _firestoreRepository.addReservation(
      _authRepository.getCurrentUser()!.uid,
      reservation,
    );
    navigatorKey.currentState!.popAndPushNamed(
      Routes.userReservations,
    );
  }
}
