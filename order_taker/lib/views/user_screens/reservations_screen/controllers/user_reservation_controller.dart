import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../repositories/auth_repository.dart';
import '../../../../repositories/firestore_repository.dart';
import '../../../resources/route_manager.dart';

class UserReservationController extends StateNotifier<void> {
  final FirestoreRepository _firestoreRepository;
  final AuthRepository _authRepository;

  UserReservationController({
    required FirestoreRepository firestoreRepository,
    required AuthRepository authRepository,
  })  : _firestoreRepository = firestoreRepository,
        _authRepository = authRepository,
        super(null);

  Future<void> deleteReservation(
    BuildContext context,
    Widget cancelReservationDialog,
  ) async {
    await showDialog(
      context: context,
      builder: (_) => cancelReservationDialog,
    );
  }

  Future<void> navigateToMenu(Reservation reservation) async {
    if (await _firestoreRepository.checkUserReservation(
      reservation,
      _authRepository.getCurrentUser()!.uid,
    )) {
      await navigatorKey.currentState!.popAndPushNamed(
        Routes.userMenu,
        arguments: reservation,
      );
    }
  }
}
