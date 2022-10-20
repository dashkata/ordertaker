import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../providers/repository_providers.dart';
import '../../../resources/route_manager.dart';

class BillScreenNotifier extends StateNotifier<void> {
  BillScreenNotifier({required StateNotifierProviderRef ref})
      : _ref = ref,
        super(null);
  final StateNotifierProviderRef _ref;

  void navigateToMenu(Reservation reservation) {
    navigatorKey.currentState!.popAndPushNamed(
      Routes.userMenu,
      arguments: reservation,
    );
  }

  Future<void> pay(Reservation reservation) async {
    await _ref.read(firestoreRepositoryProvider).deleteReservation(
          _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
          reservation,
        );
    await navigatorKey.currentState!.popAndPushNamed(Routes.userRestaurants);
  }
}
