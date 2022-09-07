import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/repositories/auth_repository.dart';
import 'package:order_taker/repositories/firestore_repository.dart';
import 'package:order_taker/views/resources/route_manager.dart';

class UserReservationStateNotifier extends StateNotifier<void> {
  final FirestoreRepository _firestoreRepository;
  final AuthRepository _authRepository;

  UserReservationStateNotifier({
    required FirestoreRepository firestoreRepository,
    required AuthRepository authRepository,
  })  : _firestoreRepository = firestoreRepository,
        _authRepository = authRepository,
        super(null);

  Future<void> deleteReservation(Reservation reservation) async {
    await _firestoreRepository.deleteReservation(
      _authRepository.getCurrentUser()!.uid,
      reservation,
    );
  }

  void navigateToMenu(Reservation reservation) {
    navigatorKey.currentState!.popAndPushNamed(
      Routes.userMenu,
      arguments: reservation,
    );
  }
}
