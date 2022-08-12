import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/user_model.dart';
import 'package:order_taker/providers/repository_providers.dart';

import '../views/user_screens/reservations_screen/reservation_state.dart';

class ReservationStateNotifier extends StateNotifier<ReservationState> {
  ReservationStateNotifier(this.ref) : super(const ReservationLoading());
  final Ref ref;

  Future<void> fetchReservations() async {
    try {
      CustomUser customUser = await ref
          .read(firestoreRepositoryProvider)
          .fetchCurrentUser(ref.read(authRepositoryProvider));
      final reservations = await ref
          .read(firestoreRepositoryProvider)
          .fetchReservations(customUser.uid);
      state = ReservationLoaded(reservations);
    } catch (e) {
      state = ReservationError(e.toString());
    }
  }
}
