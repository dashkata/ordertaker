import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../repositories/auth_repository.dart';
import '../../../../repositories/firestore_repository.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../project_widgets.dart';
import '../../../resources/route_manager.dart';

class UserReservationStateNotifier extends StateNotifier<void> {
  final FirestoreRepository _firestoreRepository;
  final AuthRepository _authRepository;

  UserReservationStateNotifier({
    required FirestoreRepository firestoreRepository,
    required AuthRepository authRepository,
  })  : _firestoreRepository = firestoreRepository,
        _authRepository = authRepository,
        super(null);

  Future<void> deleteReservation(
    Reservation reservation,
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (_) => CustomAlertDialog(
        title: Center(
          child: Text(
            'Are you sure you want to cancel your reservation?',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              buttonText: 'Cancel',
              buttonFunc: () => navigatorKey.currentState!.pop(),
            ),
            CustomButton(
              buttonText: 'Confirm',
              buttonFunc: () async {
                await _firestoreRepository.deleteReservation(
                  _authRepository.getCurrentUser()!.uid,
                  reservation,
                );
                navigatorKey.currentState!.pop();
              },
            ),
          ],
        ),
      ),
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
