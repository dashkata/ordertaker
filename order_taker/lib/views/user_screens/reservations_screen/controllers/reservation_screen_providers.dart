import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../providers/repository_providers.dart';
import 'user_reservation_controller.dart';

final reservationListProvider = StreamProvider.autoDispose<List<Reservation>>(
  (ref) => ref.watch(firestoreRepositoryProvider).fetchReservations(
        ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);
final reservationsControllerProvider =
    StateNotifierProvider<UserReservationController, void>(
  (ref) => UserReservationController(
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
  ),
);
