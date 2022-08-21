import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/repository_providers.dart';

final fetchReservationProvider =
    StreamProvider.autoDispose<List<Reservation>>((ref) {
  return ref.watch(firestoreRepositoryProvider).fetchReservations(
      ref.watch(authRepositoryProvider).getCurrentUser()!.uid);
});
