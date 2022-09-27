import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reservation_model.dart';
import 'repository_providers.dart';

final fetchReservationProvider = StreamProvider.autoDispose<List<Reservation>>(
  (ref) => ref.watch(firestoreRepositoryProvider).fetchReservations(
        ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);
