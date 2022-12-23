import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'user_reservation_controller.dart';

final reservationListProvider = StreamProvider.autoDispose<List<Reservation>>(
  (ref) => ref.watch(reservationRepositoryProvider).fetchReservations(
        ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);
final reservationsControllerProvider =
    StateNotifierProvider.autoDispose<UserReservationController, void>(
  (ref) => UserReservationController(
    reservationRepo: ref.watch(reservationRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
  ),
);
